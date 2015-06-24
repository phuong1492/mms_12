class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user 
  
  def index
    @users = User.without_user(current_user).paginate page: params[:page],
                                                      per_page: Settings.index.page
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
    @user.position_users.build
    @positions = Position.all
  end

  def create
    @user = User.new user_params
    if @user.save 
      flash[:success] = t "admin.user.create_suc"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.user.create_fail"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :birthday,
      :password, :password_confirmation, :role,
      position_users_attributes: [:id, :user_id, :position_id, :_destroy]
   end
end
