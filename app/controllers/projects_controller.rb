class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.order(params[:sort]).page(params[:page]).per(3)
  end

  def show
    @project = Project.find(params[:id])
    authorize! @project, to: :show
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
      redirect_to projects_path, notice: result.message
    else
      redirect_to projects_path(@project), notice: result.message
    end

  end

# ----------------DELETE-----------------------
  def destroy
    @project = Project.find(params[:id])

    result = Projects::DeleteProject.call(project: @project, current_user: current_user)

    if result.success?
      redirect_to projects_path, notice: result.message
    else
      redirect_to projects_path(@project), notice: result.message
    end
  end



  private

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
