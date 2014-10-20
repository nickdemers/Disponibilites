class Disponibilite < ActiveRecord::Base
  include DisponibiliteValidations

  has_one :endroit
  has_one :niveau
  belongs_to :utilisateur_absent, :class_name => 'Utilisateur'
  belongs_to :utilisateur_remplacant, :class_name => 'Utilisateur'

  validates_presence_of :utilisateur_absent_id, :endroit_id, :niveau_id, :date_heure_debut, :date_heure_fin, :statut
  validates_numericality_of :utilisateur_absent_id, :endroit_id, :niveau_id, integer_only: true
  validates_numericality_of :utilisateur_remplacant_id, allow_nil: true

  validate :date_debut_avant_date_fin
  validate :dates_non_passees
  validate :disponible
end
