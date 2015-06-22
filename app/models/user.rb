class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users, foreign_key: "user_id",
    dependent: :destroy

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users, foreign_key: "user_id"

  belongs_to :team, inverse_of: :leader


  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users, foreign_key: "user_id",
    dependent: :destroy
  
  has_many :position_users, dependent: :destroy
  has_many :positions, through: :position_users, foreign_key: "user_id",
    dependent: :destroy

  scope :without_user, -> user {where.not id: user}
  
  def is_admin?
    role == Settings.user.role.admin
  end
end
