require 'rails_helper'

Rspec.describe Projects::CreateProject do
  let(:current_user) { FactoryBot.create(:user) }

  it 'organizes the creation of a project' do
    sign_in current_user #Because I am using devise for the authentication

    project = FactoryBot.build_stubbed(:project)
    context = { project: project, current_user: current_user }

    expect(Projects::PrepareParams1).to receive(:call).with(context).ordered
    expect(Projects::SaveProject).to receive(:call).with(context).ordered

    expect(ProjectMailer).to receive(:project_created).with(project, current_user).and_return(double(deliver_later: true))
    expect(Projects::CreateDefaultAssignmentsJob).to receive(:perform_async).with(project.id).ordered

    #Then I execute the interactor
    result = described_class.call(context)

    #Expecting it to be successfull
    expect(result.success?).to eq(true)

  end
end
