module Projects
class SaveProject
  include Interactor

  def call
    project = Project.new(context.validated_params)

    if project.save
      context.project = project
      context.message = "Project Gracefully created"

    else
      context.fail!(message: "Failed to create a project")
    end
  end
end
end
