class DeleteProject
  include Interactor

  delegate :project, :user, to: :context

  def call
    project = context.project

    if project.destroy
      context.message = "Project Gracefully Deleted"
    else
      context.fail!(message: "Failed to delete the projects")
    end
  end

 def create_project_email
  ProjectMailer.project_destroyed(project, user).deliver_later
 end

end
