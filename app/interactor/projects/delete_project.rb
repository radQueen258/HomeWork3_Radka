 module Projects
 class DeleteProject
  include Interactor
  include Sidekiq::Worker

  delegate :project, :current_user, to: :context

  def call
    project = context.project

    if project.destroy
      context.message = "Project Gracefully Deleted"
    else
      context.fail!(message: "Failed to delete the projects")
    end
  end

  after do
    ProjectMailer.project_destroyed(current_user).deliver_later
    Projects::DeletedProjectJob.perform_async(project.id)
  end

 end
end
