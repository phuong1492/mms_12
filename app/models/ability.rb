class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
      can :create, Skill
    else
      can :read, User
      can :read, Skill
    end
  end
end