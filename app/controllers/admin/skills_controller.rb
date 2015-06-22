class Admin::SkillsController < ApplicationController
  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t "skill.createskillcomplete" 
      redirect_to skills_path
    else
      render "new"
    end
  end

  def destroy
    Skill.find(params[:id]).destroy
    flash[:success] = t "skill.delskillcompl"
    redirect_to skills_path
  end

  private 
  def skill_params
    params.require(:skill).permit :name 
  end
end
