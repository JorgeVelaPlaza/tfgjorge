class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.new(comment_params)
    @comment.user_id = current_user.id if current_user
    @comment.save!

    respond_to do |format|
        format.js # render comments/create.js.erb
    end
  end
  def edit
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.find(params[:id])

    if @comment.update(params[:comments]).permit(:body)
      redirect_to topic_path(@topic)
    else
      render 'edit'
    end

  end
  def destroy
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.find(params[:id])
    @comment.destroy
    redirect_to topic_path

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
