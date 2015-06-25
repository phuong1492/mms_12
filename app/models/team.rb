class Team < ActiveRecord::Base
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users, dependent: :destroy

  belongs_to :leader, class_name: "User"

  accepts_nested_attributes_for :team_users, allow_destroy: true
end
