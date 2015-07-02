require "rails_helper"

describe "admins/users/_user" do  
  before :each do
    @user = FactoryGirl.create :user
  end

  it "show information of user" do
    render "admin/users/user", user: @user
    expect(rendered).to include @user.name
  end

  describe "rendering the user partial" do
  let(:user) {FactoryGirl.create :user, name: "Phuong"}
    it "displays the user's username" do
      render "admin/users/user", user: user
      expect(rendered).to match /Phuong/
    end
  end
end
