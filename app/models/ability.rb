class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=  User.new

    alias_action :create, :read, :update, :to => :cru

    case user.role.to_sym
    when :super_admin
        can :manage, :all
    when :admin
        can :manage, Wiki
        can :cru, User
    when :common
        can :manage, Wiki
    end

  end
end
