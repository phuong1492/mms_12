class Admin::PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :set_position, except: [:index, :new, :create]
  
  def index
    @positions = Position.paginate page: params[:page], 
      per_page: Settings.index.page
  end

  def show
  end

  def edit
  end

  def update
    if @position.update position_params
      flash[:info] = t "admin.position.update"
      redirect_to admin_position_path @position
    else
      render :edit
    end
  end

  def destroy
    if @position.destroy
      flash[:success] = t "admin.position.destroy"
    else
      flash[:fail] = t "admin.position.destroy_fail"
    end
    redirect_to admin_positions_path
  end

  private
  def set_position
    @position = Position.find params[:id]
  end

  def position_params
    params.require(:position).permit :name, :abbreviation
  end
end
