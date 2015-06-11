class Team < ActiveRecord::Base
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users, foreign_key: "team_id", dependent: :destroy

  has_one :leader, class_name: "User", foreign_key: "id"
end
