class Admin::PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user 
  
  def index
    @positions = Position.all 
    @positions = @positions.paginate page: params[:page], per_page: Settings.index.page
  end
end
