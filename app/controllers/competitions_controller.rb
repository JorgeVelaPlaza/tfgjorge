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

    if @competition.idCompImportWinners == 0
      if @competition.save
        @competition.delay(run_at: @competition.startdate).start_competition_regular
        @competition.delay(run_at: @competition.deadline).finish_competition
        flash[:notice] = "Competition successfully created"
        redirect_to competition_path(@competition)
      else
        render 'new'
      end
    else
      @competitionImport = Competition.find(@competition.idCompImportWinners)
      if @competitionImport.real_winners < @competition.real_winners
        puts @competition.real_winners
        puts @competitionImport.real_winners
        flash[:danger] = "Winners to import are less than the users of the new competition"
        render 'new'
      else
        if @competition.save
          @competition.import_winners(@competitionImport)
          @competition.delay(run_at: @competition.deadline).finish_competition
          flash[:notice] = "Competition successfully created"
          redirect_to competition_path(@competition)
        else
          render 'new'
        end
      end
    end
  end

  def update
    if @competition.update(competition_params)

      #send email
      id = @competition.id
      CompetitionMailer.send_update_competition_email(@competition.users, @competition)

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
    flash[:notice] = "Competition successfully deleted"
    redirect_to competitions_path
  end

  def leaderboard

  end

  def discussions

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
      :resources, :timeline, :tutorial, :rules, :summary, :trainingdata,
      :testdata, :metric, :type_competition,:finished, :started, :startdate,
      :nGroups, :nWinners, :idCompImportWinners)
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
