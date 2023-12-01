require 'rails_helper'

RSpec.describe Projects::CreateProject do
  let(:interactor) {described_class.new(project: project)}
  # let(:current_user) { FactoryBot.create(:user) }

  describe ".organized" do
    let(:expected_interactors) do
      [
        Projects::PrepareParams1,
        Projects::SaveProject
      ]

      end

      it "organizes the interactors" do
        expect(described_class.organized).to eq(expected_interactors)
      end
  end

  describe "#after" do
    let(:project) {FactoryBot.create(:project)}
    # let(:current_user) {FactoryBot.create(:user)}

    before do
      allow(interactor).to receive(:call)

      allow(Projects::CreateDefaultAssignmentsJob).to receive(:perform_async)
      allow(ProjectMailer).to receive(:project_created).and_call_original

      @current_user = FactoryBot.create(:user)
      allow(interactor).to receive(:current_user).and_return(@current_user)
    end

    it "send email" do
      expect(ProjectMailer).to receive(:project_created).and_return(double(deliver_later: true)).with(project, @current_user)

      interactor.run

      expect(Projects::CreateDefaultAssignmentsJob).to have_received(:perform_async).with(project.id)
    end
  end

end
