class GroupsController < ApplicationController
  #before_action :set_competition, only: [:edit, :update, :show, :destroy]
  #before_filter :check_for_cancel, :only => [:edit]
  #before_filter :check_for_create_competition, :only => [:edit]


  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def edit

  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "Group successfully created"
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "Group successfully updated"
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @group.destroy
    flash[:notice] = "Group successfully deleted"
    redirect_to groups_path
  end


  #Private methods

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:users_group, :comp_id)
  end

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to root_path
    end
  end

  def check_for_create_group
    if params[:commit] == "Create competition"
      redirect_to user_path(@user)
    end
  end
end

