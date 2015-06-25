class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :set_team, except: [:index, :new, :create]
  
  def index
    @teams = Team.paginate page: params[:page], 
                           per_page: Settings.index.page
  end

  def show
  end

  def new
    @team = Team.new
    @leaders = User.user_not_in_team
    @team.team_users.build
  end

  def create
    @team = Team.new team_params
    if @team.save
      @team.users << @team.leader
      flash[:success] = t "admin.team.create_suc" 
      redirect_to admin_team_path @team
    else
      render :new
    end
  end

  private
  def set_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit :name, :description,:leader_id,
                                 :team_id, user_ids: [],
                                 team_users_attributes: [:id, :user_id, :team_id, :_destroy]
  end
end
