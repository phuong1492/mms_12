class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  
  def show
  end

  def update
    if @user.update_attributes user_params
      if params[:flag] == Settings.user.one
        respond_to do |format|
          format.html {redirect_to user_add_skills_path @user}
          format.js
        end
      else 
        respond_to do |format|
          format.html {redirect_to @user}
          format.js
        end
      end
    else
      redirect_to user_add_skills_path current_user
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :birthday, :email, :encrypted_password,
                                  skill_users_attributes: [:id, :level, :used_year, :_destroy],
                                  skill_ids: []
  end
end
