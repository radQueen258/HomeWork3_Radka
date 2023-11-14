class CreateProject
  include Interactor::Organizer

  delegate :project, :user, to: :context

  organize PrepareParams1, SaveProject

  # def create_project_email
  #   ProjectMailer.project_created(project, user).deliver_later
  # end

  after do
    ProjectMailer.project_created(project, user).deliver_later
    Projects::CreateDefaultAssignmentsJob.perform_async(project.id)
  end

end
