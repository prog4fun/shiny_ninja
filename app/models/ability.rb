class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    
    if user.is? :administrator
      can :manage, :all
    elsif user.is? :time_tracker
      can :manage, Customer
      can :manage, Project
      can :manage, Report
      can :manage, Service
      can :tt_show, User
      can :tt_index, User
      can :tt_new, User
      can :tt_edit, User
      can :create, User
      can :update, User
      can :destroy, User
    elsif user.is? :project_evaluator
      can :index, Report
      can :show, Report
      can :pe_show, User
      can :pe_edit, User
      can :update, User
    end
    
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
