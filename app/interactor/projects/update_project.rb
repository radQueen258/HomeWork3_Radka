module Projects
class UpdateProject
  include Interactor

  delegate :project,:current_user, :project_params, to: :context

  def call

    if project.update(project_params)

      context.message = "Project Gracefully Updated"

    else
      context.fail!(message: "Failed to update the project")
    end
  end

  after do
    if context.success?
    ProjectMailer.project_updated(project, current_user).deliver_later
    Projects::UpdatedProjectJob.perform_async(project.id)
    end
  end
end
end
