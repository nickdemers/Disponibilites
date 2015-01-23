class Ability
  include CanCan::Ability

  def initialize(user)
    #TODO remettre
    user ||= Utilisateur.new # guest user

    #if user.role? :super_admin
      can :manage, :all
=begin
    elsif user.role? :commission_scolaire_admin
      can :manage, [Disponibilite, Utilisateur]
    elsif user.role? :professeur_permanent
      #can :read, [Product, Asset]
      # manage products, assets he owns
      can :manage, Disponibilite do |disponibilite|
        disponibilite.try(:utilisateur_absent) == user
      end
      can :manage, Utilisateur do |utilisateur|
        utilisateur.try(:utilisateur) == user
      end
    elsif user.role? :professeur_remplacant
      #can :read, [Product, Asset]
      # manage products, assets he owns
      can :read, Disponibilite do |disponibilite|
        disponibilite.try(:utilisateur_remplacant) == user
      end
      can :manage, Utilisateur do |utilisateur|
        utilisateur.try(:utilisateur) == user
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
  end
end