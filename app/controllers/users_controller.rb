class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_authorization, only: [:edit, :update]
  before_action :set_user

  before_filter :check_for_cancel, :only => [:edit]
  before_filter :check_for_save_changes, :only => [:edit]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Datos de perfil actualizados correctamente"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :pais, :ciudad, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_for_cancel
    if params[:commit] == "Cancelar"
      redirect_to root_path
    end
  end

  def check_for_save_changes
    if params[:commit] == "Guardar cambios"
      redirect_to user_path(@user)
    end
  end

  def check_authorization
    unless current_user.id == params[:id].to_i
      redirect_to root_path
    end
  end
end
