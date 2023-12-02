module Api
  module V1
    class ProjectsController < Api::ApplicationController
      before_action :set_project, only: %i[show edit update destroy]

      def index
        @projects = Project.order(params[:sort]).page(params[:page]).per(3)
        render json: @projects, each_serializer: ProjectSerializer
      end

      def show
        @project = Project.find(params[:id])
        render json: @project, serializer: ProjectSerializer
      end

      def new
        @project = Project.new
      end

      # def edit
      # end
    # -----------------------CREATE------------------------
      def create

        result = Projects::CreateProject.call(project_params: project_params, current_user: current_user)

        if result.success?
          redirect_to result.project, notice: result.message

        else
          redirect_to new_project_path, alert: result.message
        end

      end

    # -----------------------UPDATE------------------
      def update
        @project = Project.find(params[:id])
        updated_attributes = project_params

        result = Projects::UpdateProject.call(project: @project, updated_attributes: updated_attributes, current_user: current_user)

        if result.success?
          render json: { project: @project, message: "Update Successful" }
        else
          render json: { message: "Error" }
        end

      end

    # ----------------DELETE-----------------------
      def destroy
        @project = Project.find(params[:id])

        result = Projects::DeleteProject.call(project: @project, current_user: current_user)

        if result.success?
          render json: { message: "Project Dstroyed" }
        else
          render json: { message: "Error" }
        end
      end


      private

      def set_project
        @project = Project.find_by(id: params[:id])
      end

      def project_params
        params.required(:project).permit(:name, :description)
      end

    end
  end
end
