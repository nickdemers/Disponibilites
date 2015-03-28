class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? :super_admin
      can :manage, :all
      can :accept_availability, Disponibilite, :user_remplacant_id => user.id
      can :deny_availability, Disponibilite, :user_remplacant_id => user.id
    elsif user.role? :admin
      can :manage, Ecole
      can :manage, User
      can :manage, Disponibilite
      can :accept_availability, Disponibilite, :user_remplacant_id => user.id
      can :deny_availability, Disponibilite, :user_remplacant_id => user.id
      cannot :manage, Role
    elsif user.role? :permanent
      can :update, User, :id => user.id
      can :show, User, :id => user.id
      cannot :destroy, User, :id => user.id
      can :read, :Disponibilite
      can :create, :Disponibilite
      can :manage, Disponibilite, :user_absent_id => user.id
      can :update, Disponibilite, :user_remplacant_id => user.id
      can :show, Disponibilite, :user_remplacant_id => user.id
      cannot :destroy, Disponibilite, :user_remplacant_id => user.id
      can :accept_availability, Disponibilite, :user_remplacant_id => user.id
      can :deny_availability, Disponibilite, :user_remplacant_id => user.id
      cannot :manage, Ecole
      can :read, Ecole
      cannot :manage, Role
      can :read, Role
    elsif user.role? :remplacant
      can :read, :all
      can :update, User, :id => user.id
      can :show, User, :id => user.id
      cannot :destroy, User, :id => user.id
      cannot :manage, :Disponibilite
      #can :update, Disponibilite, :user_remplacant_id => user.id
      can :show, Disponibilite, :user_remplacant_id => user.id
      can :accept_availability, Disponibilite, :user_remplacant_id => user.id
      can :deny_availability, Disponibilite, :user_remplacant_id => user.id
      #cannot :destroy, Disponibilite, :user_remplacant_id => user.id
      cannot :manage, Ecole
      cannot :manage, Role
    end
  end

  #def initialize(user)
    #TODO remettre
  #  user ||= User.new # guest user

    #if user.role? :super_admin
  #    can :manage, :all
=begin
    elsif user.role? :commission_scolaire_admin
      can :manage, [Disponibilite, User]
    elsif user.role? :professeur_permanent
      #can :read, [Product, Asset]
      # manage products, assets he owns
      can :manage, Disponibilite do |disponibilite|
        disponibilite.try(:user_absent) == user
      end
      can :manage, User do |user|
        user.try(:user) == user
      end
    elsif user.role? :professeur_remplacant
      #can :read, [Product, Asset]
      # manage products, assets he owns
      can :read, Disponibilite do |disponibilite|
        disponibilite.try(:user_remplacant) == user
      end
      can :manage, User do |user|
        user.try(:user) == user
      end
    end
=end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
 # end
end
