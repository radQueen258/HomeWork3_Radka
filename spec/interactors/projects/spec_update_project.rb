require 'rails_helper'

RSpec.describe Projects::UpdateProject do

describe '.call' do

 let(:project) { FactoryBot.create(:project) }
 let(:updated_attributes) { { name: 'New Project Name Tester' } }

  before do
     @current_user = FactoryBot.create(:user)
  end


  context 'updating project with success' do

   let(:context) { { project: project, current_user: @current_user, project_params: updated_attributes } }

      it 'updates the project and sets the success message' do

        result = described_class.call(context)

        expect(result.project.name).to eq('New Project Name Tester')
        expect(result.message).to eq('Project Gracefully Updated')
      end

     it 'triggers ProjectMailer and UpdatedProjectJob' do

          allow(ProjectMailer).to receive(:project_updated).and_call_original

          expect(ProjectMailer).to receive(:project_updated).with(project, @current_user).and_return(double(deliver_later: true))
          allow(Projects::UpdatedProjectJob).to receive(:perform_async).with(project.id)

          described_class.call(context)
      end

 end

  context 'when failing to update the project' do

      it 'fails to update the project and sets failure message' do

        invalid_attributes = { name: '' } # an invalid attribute
        invalid_context = { project: project, current_user: @current_user, project_params: invalid_attributes }

        result = described_class.call(invalid_context)
        expect(result).to be_a_failure
        expect(result.message).to eq('Failed to update the project')

      end

      it 'does not trigger ProjectMailer and UpdatedProjectJob' do

        invalid_attributes = { name: '' } # an invalid attribute
        invalid_context = { project: project, current_user: @current_user, project_params: invalid_attributes }

        expect(ProjectMailer).not_to receive(:project_updated).with(project, @current_user)
        expect(Projects::UpdatedProjectJob).not_to receive(:perform_async).with(project.id)

        described_class.call(invalid_context)
      end

 end
end
end
