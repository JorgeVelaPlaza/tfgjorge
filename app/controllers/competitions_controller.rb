class CompetitionsController < ApplicationController
  def new
    @competition = Competition.new
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

  def show
    @competition = Competition.find(params[:id])
  end


  private
  def competition_params
    params.require(:competition).permit(:titulo, :descripcion, :premio,
      :deadline, :dificultad)
  end
end
