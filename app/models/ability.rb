class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=  User.new

    alias_action :create, :read, :update, :to => :cru

    case user.try(:role)
    when :super_admin.to_s
        can :manage, :all
    when :admin.to_s
        can :manage, Wiki
        can :cru, User
    when :common.to_s
        can :manage, Wiki
    end

  end
end
