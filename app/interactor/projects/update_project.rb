module Projects
class UpdateProject
  include Interactor
  include Sidekiq::Worker

  delegate :project, :current_user, to: :context

  def call
    project = context.project
    updated_attributes = context.updated_attributes

    if project.update(updated_attributes)
      context.project = project
      context.message = "Project Gracefully Updated"

    else
      context.fail!(message: "Failed to update the project")
    end
  end

  after do
    ProjectMailer.project_updated(project, current_user).deliver_later
    Projects::UpdatedProjectJob.perform_async(project.id)
  end
end
end
