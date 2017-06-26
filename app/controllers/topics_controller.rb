class TopicsController < ApplicationController

  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all.order("created_at DESC")
    respond_to do |format|
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end

  end


  def new

    @topic = Topic.new
    respond_to do |format|
      format.js
    end
  end

  def create
    #@topic.competition_id = params[:comp_id]
    #@competition = Competition.find(params[:id => :competition_id])
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id if current_user
    @topic.competition_id = params[:competition_id]
    @topic.save!

    respond_to do |format|
      format.js
    end
  end

  def edit

  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to root_path

  end


  private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, :competition_id)
  end
end
