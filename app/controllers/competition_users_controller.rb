class CompetitionUsersController < ApplicationController
  before_action :set_compuser, only: [:update]
  def index
    @competition_users = Competition.all
  end

  def new
    @competition_user = CompetitionUser.new
  end

  def edit
    @competition_user = CompetitionUser.find(params[:id])
  end

  def create

    @competition_user = CompetitionUser.new(competition_user_params)
    if @competition_user.save
      flash[:notice] = "Congratulations, you are enroll! GOOD LUCK!"
      redirect_to competitions_path
    else
      render 'new'
    end
  end

  def update
    if @competition_user.update(competition_user_params)

      flash[:notice] = "Your prediction has been submitted, Congratulations!"
      redirect_to competitions_path
    else
      render 'edit'
    end
  end

  def show
  end


  def destroy
  end

  private

  def competition_user_params
    params.require(:competition_user).permit(:competition_id, :user_id, :predicfile)
  end

  def set_compuser
    @competition_user = CompetitionUser.find(params[:id])
  end

end
