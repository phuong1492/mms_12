class Admin::TeamsController < ApplicationController
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
    @free_users = User.not_in_team
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

  def edit
    @free_users = User.not_in_team
    @users_in_team = @team.users.pluck :name, :id
    @leaders = @free_users + @team.users
  end

  def update
    if @team.update_attributes team_params
      check_leader
      flash[:success] = t "admin.team.success"
      redirect_to admin_team_path @team
    else
      render :edit
    end
  end

  def destroy
    if @team.destroy
      flash[:success] = t "admin.team.deleted_team"
    else
      flash[:fail] = t "admin.team.delete_fail" 
    end 
    redirect_to admin_teams_path
  end

  private
  def set_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit :name, :description, :leader_id,
                                 :team_id, user_ids: []
  end

  def check_leader 
    @team.users << @team.leader unless @team.users.
      find_by id: team_params[:leader_id]
  end
end
