module Projects

class CreateProject
  include Interactor::Organizer

  delegate :project, :current_user, to: :context

  organize Projects::SaveProject
# Projects::PrepareParams1,
  after do
    ProjectMailer.project_created(project, current_user).deliver_later
    Projects::CreateDefaultAssignmentsJob.perform_async(project.id)
  end

end

end
