class SkillsController < ApplicationController
  def index
    @skills = Skill.paginate page: params[:page]
  end
  
  def show
    @skill = Skill.find params[:id]
  end
end
