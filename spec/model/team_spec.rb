require "rails_helper"

RSpec.describe Team, type: :model do
  before do
    @team = FactoryGirl.build :team
  end

  context "Team" do
    before do
      @users = []
      2.times {@users << FactoryGirl.build(:user)}
      @user = FactoryGirl.build :user
    end

    it "should be vaild" do
      expect(@team).to be_valid
    end

    it "should be vaild when name is null" do
      @team.name = nil
      expect(@team).to be_valid
    end

    it "should be vaild when leader is null" do
      @team.leader = nil
      expect(@team).to be_valid
    end

    it "should valid when team's leader is user" do
      @team.leader = @user
      expect(@team.leader).to eql @user
    end

    it "user has no team after delete user's team" do
      @team.users << @user
      @team.destroy
      expect(@user.teams.count).to eql 0
    end

    it "team dont have user after delete use" do
      @team.users << @user
      @user.destroy
      expect(@team.users.count).to eql 0
    end
  end
end
