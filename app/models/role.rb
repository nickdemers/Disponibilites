class Role < ActiveRecord::Base

  before_destroy :valide_presence_user

  has_and_belongs_to_many :users

  validates_presence_of :nom
  validates_length_of :nom, :maximum => 255

  def valide_presence_user
    if !self.users.blank?
      errors.add(:base, "Le rôle ne peut pas être supprimé car il est assigné à un utilisateur.\n")
      return false
    end
  end

end
