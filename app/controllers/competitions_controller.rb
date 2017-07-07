class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:edit, :update, :show, :destroy, :leaderboard]
  before_filter :check_for_cancel, :only => [:edit]
  #before_filter :check_for_create_competition, :only => [:create]
  #before_filter :check_for_update_competition, :only => [:update]



  def index
    @competitions = Competition.all
  end

  def new
    @competition = Competition.new
  end

  def edit

  end

  def create
    @competition = Competition.new(competition_params)
    if @competition.save
      flash[:notice] = "Competition successfully created"
      redirect_to competition_path(@competition)
    else
      render 'new'
    end
  end

  def update
    if @competition.update(competition_params)

      #send email
      id = @competition.id
      CompetitionMailer.update_competition(id).deliver

      flash[:notice] = "Competition successfully updated"
      redirect_to competitions_path
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @competition.destroy
    flash[:notice] = "Competicion eliminada correctamente"
    redirect_to competitions_path
  end

  def leaderboard

  end

  def discussions

  end

  def overview
    respond_to do |format|
      format.js
    end
  end

  def show_topics
    @competition = Competition.find(params[:topics])
  end


#Private methods

  private

  def set_competition
    @competition = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:titulo, :descripcion, :premio,
      :deadline, :dificultad, :evaluation, :prizes, :about, :engagement,
      :resources, :timeline, :tutorial, :rules, :summary, :trainingdata, :testdata, :metric)
  end

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to competitions_path
    end
  end

  def check_for_create_competition
    if params[:commit] == "Create competition"
      redirect_to competitions_path
    end
  end

  def check_for_update_competition
    if params[:commit] == "Update competition"
      redirect_to competitions_path
    end
  end
end
