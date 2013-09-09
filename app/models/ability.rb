class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    
    if user.is? :administrator
      can :manage, :all
      # e.g. admins mustn't evaluate projects
      cannot :manage, ProjectsUser
    elsif user.is? :time_tracker
      can :manage, Customer
      can :manage, ProjectsUser
      can :manage, Project
      can :manage, Report
      can :manage, Service
      can :manage, ProjectsUser
      # Do not user :read, because read = show + index
      can :show, User  # To Show own Account --> UserController#Show
      can :update, User  # To Edit own Account --> UserController#Edit
    elsif user.is? :project_evaluator
      can :index, Report
      can :show, Report
      can :show, User  # To Show own Account --> UserController#Show
      can :update, User  # To Edit own Account --> UserController#Edit
      can :update, ProjectsUser
      can :confirm_project_evaluator, ProjectsUser
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
