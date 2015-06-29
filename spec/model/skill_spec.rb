require "rails_helper"

RSpec.describe Skill, type: :model do
  before do
    @skill = FactoryGirl.build :skill
  end

  context "Skill" do
    it "should be vaild" do
      expect(@skill).to be_valid
    end

    it "should be vaild when name is null" do
      @skill.name = nil
      expect(@skill).to be_valid
    end
  end
end
