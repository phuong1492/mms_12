require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.build :user, role: "admin"
  end

  context "User" do
    it "should be vaild" do
      expect(@user).to be_valid
    end

    it "when user is admin" do
      expect(@user.role).to eq "admin"
    end

    it "birthday is null?" do
      expect(@user.birthday).to be_nil
    end
  end

  context "Email" do
    it "should invalid when empty" do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it "should be uniqueness" do
      @user.email = "example@gmail.com"
      @user.save
      other_user = FactoryGirl.build :user, email: "example@gmail.com" 
      expect(other_user).not_to be_valid
    end

    it "should invalid when wrong format 1" do
      @user.email = "examle.com"
      expect(@user).not_to be_valid
    end

    it "should invalid when wrong format 2" do
      @user.email = "examle@gmailcom"
      expect(@user).not_to be_valid
    end
  end

  context "Name" do
    it "should invalid when empty" do
      @user.name = nil
      expect(@user).not_to be_valid
    end

    it "should be not uniqueness" do
      @user.name = "phuong"
      other_user = FactoryGirl.build :user, name: "phuong"
      expect(other_user).to be_valid
    end
  end

  context "Password" do
    it "should invalid when empty" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).not_to be_valid
    end
    it "should invalid when password_confimation different with password" do
      @user.password = "password"
      @user.password_confirmation = "12345678"
      @user.save
      expect(@user).not_to be_valid
    end

    it "should invalid when length smaller than 8" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user).not_to be_valid
    end
  end

  context "test scope" do
    before do
      @users = []
      10.times {@users << FactoryGirl.create(:user)}
      @user = FactoryGirl.create :user
    end

    it "test scope without user" do
      expect(User.without_user(@user)).not_to include User.all 
    end

    it "test scope user not in team" do
      team = FactoryGirl.build :team
      team.users << @user
      expect(User.not_in_team).not_to include team.users
    end
  end
  
  context "user-skill" do
    before do
      @skills = []
      10.times {@skills << FactoryGirl.build(:skill)}
      @skill = FactoryGirl.build :skill
    end

    it "should vaild when user has many skills" do
      @user.skills = @skills
      @user.save
      expect(@user.skills.count).to eql 10
    end

    it "should vaild when user has no skill" do
      @user.skills = []
      @user.save
      expect(@user.skills.count).to eql 0
    end

    it "check level and used_year of skill user" do
      @user.skills << @skill
      @user.skill_users.last.level = 3
      @user.skill_users.last.used_year = 3
      @user.save
      expect(@user.skill_users.last.level).to eql 3
      expect(@user.skill_users.last.used_year).to eql 3
    end
  end
  describe "test associations" do
    context "test have_many" do
      let(:user) {FactoryGirl.build(:user)}
      it {expect(user).to have_many(:skills)}
      it {expect(user).to have_many(:positions)}
      it {expect(user).to have_many(:teams)}
      it {expect(user).to have_many(:projects)}
      it {expect(user).to have_many(:skill_users).dependent(:destroy)}
      it {expect(user).to have_many(:position_users).dependent(:destroy)}
      it {expect(user).to have_many(:team_users).dependent(:destroy)}
      it {expect(user).to have_many(:project_users).dependent(:destroy)}
    end

    context "test has_one" do
      let(:user) {FactoryGirl.build(:user)}
      it {expect(user).to have_one(:leading_team)}
    end
  end
end
