class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:edit, :update, :show, :destroy]


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
      flash[:notice] = "Competicion creada correctamente"
      redirect_to competition_path(@competition)
    else
      render 'new'
    end
  end

  def update
    if @competition.update(competition_params)
      flash[:notice] = "Competicion actualizada correctamente"
      redirect_to competition_path(@competition)
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


  private
  def set_competition
    @competition = Competition.find(params[:id])
  end
  def competition_params
    params.require(:competition).permit(:titulo, :descripcion, :premio,
      :deadline, :dificultad)
  end
end
