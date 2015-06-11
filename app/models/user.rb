class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users, foreign_key: "user_id",
    dependent: :destroy

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users, foreign_key: "user_id",
    dependent: :destroy

  belongs_to :team, inverse_of: :leader
end
