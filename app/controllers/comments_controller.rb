class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @comment = Comment.new

  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @comment = current_user.comments.build(comment_params)
    @comment.assignment = @assignment

    result = Comments::CreateComment.call(
      assignment: @assignment,
      user: current_user,
      comment_params: comment_params
    )
    if result.success?
      redirect_to assignment_path(@assignment), notice: result.message
     else
      redirect_to assignment_path(@assignment), notice: result.message
    end
  end


  def index
    @comments = Comment.all
  end


  def update

    @comment = Comment.find(params[:id])
    comment_params = params.require(:comment).permit(:content)

    result = Comments::UpdateComment.call(comment: @comment, comment_attributes: comment_params)

    if result.success?
      redirect_to @comment.assignment, notice: result.message
    else
      redirect_to @comment.assignment, alert: result.message
    end
  end



  def destroy
     @comment = Comment.find(params[:id])

     result = DeleteComment.call(comment: @comment)

     if result.success?
      redirect_to @comment.assignment, notice: result.message
     else
      redirect_to @comment.assignment, notice: result.message
     end
  end


  def comment_params
    params.require( :comment).permit( :content, :user_id, :assignment_id)
  end

end
