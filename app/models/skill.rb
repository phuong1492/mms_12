class Skill < ActiveRecord::Base
  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users, foreign_key: "skill_id",
    dependent: :destroy
end
