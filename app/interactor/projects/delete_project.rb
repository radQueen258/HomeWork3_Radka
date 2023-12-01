 module Projects
 class DeleteProject
  include Interactor

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
  end

 end
end
