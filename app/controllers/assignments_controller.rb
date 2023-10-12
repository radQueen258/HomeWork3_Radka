class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only:[:edit, :update,:destroy]
  before_action :set_project, only: [:create, :update]


  # GET /assignments or /assignments.json
  def index
    # @assignments = Assignment.all
    @assignments = Assignment.page(params[:page]).per(10)
    # @assignments = Assignment.order(assignment_name: :asc)
    case params[:sort_by]
    when 'name'
      @assignments = @assignments.order(assignment_name: :asc)
    when 'created_at'
      @assignments = @assignments.order(created_at: :asc)
    when 'deadline'
      @assignments = @assignments.order(deadline: :asc)
    end
  end

  # GET /assignments/1 or /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    #@assignment = Assignment.new
    @assignment = current_user.assignments.build
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments or /assignments.json
  def create
    #@assignment = Assignment.new(assignment_params)
    @assignment = current_user.assignments.build(assignment_params)
    @assignment = Assignment.new(assignment_params)
    @assignment.created_at = Time.zone.now
    # @assignment = Assignment.find(assignment_params[:project_id])
    @assignment.project = @project

    respond_to do |format|


      if @assignment.save
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment gracefully created." }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update

    @assignment = current_user.assignments.build(assignment_params)
    @assignment = Assignment.new(assignment_params)
    @assignment = Assignment.find(assignment_params[:project_id])
    @assignment.project = @project

    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment gracefully updated." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url, notice: "Assignment gracefully destroyed." }
      format.json { head :no_content }
    end
  end


  def correct_user
    @assignment = current_user.assignments.find_by(id: params[:id])

    redirect_to assignment_path, notice: "Not Authorized To Edit This Friend" if @assignment.nil?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.require(:assignment).permit(:assignment_name, :description, :deadline, :completion_status, :user_id, :project_id)
    end

    private
    def set_project
     @project = Project.find(params[:assignment][:project_id])
    end
end
