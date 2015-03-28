class Disponibilite < ActiveRecord::Base
  include DisponibiliteValidations

  belongs_to :ecole, :validate => true
  #has_one :niveau

  belongs_to :user_absent, :class_name => 'User'
  belongs_to :user_remplacant, :class_name => 'User'

  validates_presence_of :user_absent_id, :date_heure_debut, :date_heure_fin, :statut, :niveau_id, :ecole_id
  validates_numericality_of :niveau_id, :ecole_id, integer_only: true, allow_nil: true

  validate :date_debut_avant_date_fin
  validate :dates_non_passees
  validate :disponible

end
