module Projects

class CreateProject
  include Interactor::Organizer

  delegate :project, :current_user, to: :context

  organize Projects::PrepareParams1, Projects::SaveProject

  after do
    ProjectMailer.project_created(project, current_user).deliver_later
    Projects::CreateDefaultAssignmentsJob.perform_async(project.id)
  end

end

end
