require "rails_helper"

describe "admin/users/show" do  
  before do
    @user = FactoryGirl.create :user, role: "admin"
    @position = FactoryGirl.create :position
    @user.positions << @position
  end
  it "request to users controller and show action" do
    render
    expect(controller.request.path_parameters[:controller]).to eq "admin/users"
    expect(controller.request.path_parameters[:action]).to eq "show"
  end

  it "display information about user" do
    render
    expect(rendered).to include @user.name, @user.email
  end
end
