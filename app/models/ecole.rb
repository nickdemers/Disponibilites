class Ecole < ActiveRecord::Base

  before_destroy :valide_presence_disponibilite

  has_many :disponibilites

  validates_presence_of :nom
  validates_length_of :nom, :maximum => 255

  def valide_presence_disponibilite
    if !self.disponibilites.blank?
      errors.add(:base, "L'école ne peut pas être supprimée car elle est assignée à une disponibilité.\n")
      return false
    end
  end

end
