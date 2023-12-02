module Api
  module V1
    class AssignmentsController < Api::ApplicationController
      before_action :set_assignment, only: %i[show edit update destroy]
      before_action :authenticate_user!, except: [:index, :show]
      before_action :set_project, only: [:create, :update]
      before_action :correct_user, only: [:edit, :update, :destroy]

      def index
        if params[:project_id].present?
          @project = Project.find(params[:project_id])
          @assignments = @project.assignments
        else
          @assignments = Assignment.page(params[:page]).per(10)
        end

        case params[:sort_by]
        when 'name'
          @assignments = @assignments.order(assignment_name: :asc)

        when 'created_at'
          @assignments = @assignments.order(created_at: :asc)

        when 'deadline'
          @assignments = @assignments.order(deadline: :asc)
        end

        render json: @assignments
      end

      def show
        render json: @assignment
      end

      def new
        @assignment = current_user.assignments.build
        render  json: @assignment
      end

      def edit
        render json: @assignment
      end

      def create
        project = Project.find(assignment_params[:project_id])
        user = current_user

        result = Assignments::CreateAssignment.call(
        current_user: user,
        project_id: assignment_params[:project_id],
        assignment_params: assignment_params
        )

        if result.success?
          @assignment = result.assignment
          user = current_user
          project = Project.find(assignment_params[:project_id])
          AssignmentMailer.assignment_created(project, result.assignment, user).deliver_later
          render json: { assignment: @assignment, notice: result.message }
        else
          @assignment = Assignment.new(assignment_params)
          render json: { errors: result.message }, status: :unprocessable_entity
        end
      end

      def update
        @assignment = Assignment.find(params[:id])
        updated_attributes = assignment_params
        result = Assignments::UpdateAssignment.call(assignment: @assignment, updated_attributes: updated_attributes, current_user: current_user)

        if result.success?
          render json: { assignment: @assignment, notice: result.message }
        else
          render json: { errors: result.message }, status: :unprocessable_entity
        end
      end

      # DELETE /assignments/1 or /assignments/1.json
      def destroy
        @assignment = Assignment.find(params[:id])

        result = Assignments::DeleteAssignment.call(assignment: @assignment, current_user: current_user)

        if result.success?
          render json: { assignment: @assignment, notice: result.message }
        else
          render json: { errors: result.message }, status: :unprocessable_entity
        end
      end


      def correct_user
        @assignment = current_user.assignments.find_by(id: params[:id])

        redirect_to assignment_path, notice: "Not Authorized To Edit This Assignment" if @assignment.nil?
      end


      private
        # Use callbacks to share common setup or constraints between actions.
        def set_assignment
          @assignment = Assignment.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def assignment_params
          params.require(:assignment).permit(:assignment_name, :description, :deadline, :status, :user_id, :project_id)
        end

        private
        def set_project
         @project = Project.find(params[:assignment][:project_id])
        end
    end
  end
end
