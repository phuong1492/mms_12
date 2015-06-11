class Position < ActiveRecord::Base
  has_many :position_users, dependent: :destroy
  has_many :users, through: :position_users, foreign_key: "position_id",
    dependent: :destroy
end
