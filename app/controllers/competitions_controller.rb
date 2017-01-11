class CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all
  end

  def new
    @competition = Competition.new
  end

  def edit
    @competition = Competition.find(params[:id])
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
    if @competition.update(article_params)
      flash[:notice] = "Competicion actualizada correctamente"
      redirect_to competition_path(@competition)
    else
      render 'edit'
    end
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def destroy
    @competition = Competition.find(params[:id])
    if @competition.destroy
      flash[:notice] = "Competicion eliminada correctamente"
      redirect_to competitions_path
    else
      render 'index'
    end
  end


  private
  def competition_params
    params.require(:competition).permit(:titulo, :descripcion, :premio,
      :deadline, :dificultad)
  end
end
