# module Projects
# class SaveProject
#   include Interactor

#   def call
#     project = Project.new(context.validated_params)

#     if project.save
#       context.project = project
#       context.message = "Project Gracefully created"

#     else
#       context.fail!(message: "Failed to create a project")
#     end
#   end
# end
# end

module Projects
  class SaveProject
    include Interactor

    delegate :project_params, to: :context

    def call
      context.project = project

      context.fail!(error: "Invalid data") unless project.save

    end

    private

      def project
        @project ||= Project.new(project_params)
      end

    end
  end
