class Admin::UsersController < ApplicationController
   before_action :authenticate_user!

  def index
    @users = User.without_user current_user 
    @users = @users.paginate page: params[:page], per_page: Settings.user.index.page
  end
end
