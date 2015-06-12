class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :home
  skip_load_and_authorize_resource
  
  def home
  end

  def help
  end

  def about
  end
end
