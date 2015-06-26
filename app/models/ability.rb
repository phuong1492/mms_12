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
      can :update, User, id: user.id
      can :manage, SkillUser
    end
  end
end
