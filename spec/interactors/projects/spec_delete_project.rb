require 'rails_helper'

RSpec.describe Projects::DeleteProject do

  subject(:context) {Projects::DeleteProject.call(project: project) }

  describe '.call' do
  let(:interactor) {described_class.new(project: project)}
  let(:project) { FactoryBot.create(:project) }


    context 'when deletion of the project is successfull' do
        it 'deletes the project' do
        expect { interactor.run }.to change(Project, :count).from(1).to(0)
        end

       it 'prints a success message' do
        expect(context.message).to eq('Project Gracefully Deleted')
       end

       before do
        allow(Projects::DeletedProjectJob).to receive(:perform_async).with(project.id)
        allow(ProjectMailer).to receive(:project_destroyed).and_call_original

        @current_user = FactoryBot.create(:user)
        allow(interactor).to receive(:current_user).and_return(@current_user)

       end

        it 'triggers ProjectMailer.project_destroyed' do
          expect(ProjectMailer).to receive(:project_destroyed).and_return(double(deliver_later: true)).with(@current_user)
          interactor.run

        end
    end

    context 'when project deletion fails' do
      before do
        allow(project).to receive(:destroy).and_return(false)
      end

      it 'fails the context' do
      expect(context).to be_a_failure
      expect(context.message).to eq('Failed to delete the projects')
      end

    it 'does not trigger ProjectMailer.project_destroyed' do
      expect(ProjectMailer).not_to receive(:project_destroyed)
       context
    end

    it 'does not enqueue DeletedProjectJob' do
      expect(Projects::DeletedProjectJob).not_to receive(:perform_async)
      context
    end
  end
end
end
