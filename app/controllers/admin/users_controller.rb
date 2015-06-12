class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user 
  
  def index
    @users = User.without_user(current_user).paginate page: params[:page],
      per_page: Settings.index.page
  end
end
