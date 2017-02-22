class CompetitionUsersController < ApplicationController
  def index

  end

  def new
    @competition_user = CompetitionUser.new
  end

  def edit

  end

  def create

    @competition_user = CompetitionUser.new(competition_user_params)
    if @competition_user.save
      flash[:notice] = "Enhorabuena, te has inscrito en la competición. ¡SUERTE!"
      redirect_to competitions_path
    else
      render 'new'
    end
  end

  def update

  end

  def show
  end


  def destroy
  end

  private

  def competition_user_params
    params.permit(:competition_id, :user_id)

  end

end
