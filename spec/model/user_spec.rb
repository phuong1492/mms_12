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

  context "user-skill" do
    before do
      @skills = []
      10.times {@skills << FactoryGirl.build(:skill)}
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
  end
end
