# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:show, :index], :all
      can [:create, :new], :user
    end
  end
end
