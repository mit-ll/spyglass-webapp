class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :user
      can [:index, :new, :show, :create, :destroy], Session
      can [:index, :new, :create, :destroy], Key
    end
    if user.has_role? :admin
      can [:manage], User
    end
  end
end
