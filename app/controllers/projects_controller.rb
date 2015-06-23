class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate page: params[:page], 
      per_page: Settings.index.page
  end
end
