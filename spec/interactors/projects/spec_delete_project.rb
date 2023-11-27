require 'rails_helper'

Rspec.describe Projects::DeleteProject, type: :interactor do
  let(:current_user) { FactoryBot.create(:user) }

  it 'user creation' do
    sign_in current_user
  end

  let(:project) { FactoryBot.create(:project) }

  subject(:context) {Projects::DeleteProject.call(project: project, current_user: current_user) }

  describe '.call' do
    context 'when deletion of the project is successfull' do
        it 'deletes the project' do
        expect { context }.to change(Project, :count).by(-1)
        end

       it 'prints a success message' do
        expect(context.message).to eq('Project Gracefullt Deleted')
       end

        it 'triggers ProjectMailer.project_destroyed' do
        expect(Projects::DeletedProjectJob).to receive(:perform_async).with(project.id)
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
