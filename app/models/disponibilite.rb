class Disponibilite < ActiveRecord::Base
  include DisponibiliteValidations

  has_one :ecole
  has_one :niveau

  #has_one :utilisateur_absent, :class_name => 'Utilisateur', :dependent => :restrict_with_error
  #has_one :utilisateur_remplacant, :class_name => 'Utilisateur', :dependent => :restrict_with_error
  belongs_to :utilisateur_absent, :class_name => 'Utilisateur'
  belongs_to :utilisateur_remplacant, :class_name => 'Utilisateur'

  validates_presence_of :utilisateur_absent_id, :niveau_id, :date_heure_debut, :date_heure_fin, :statut
  validates_numericality_of :niveau_id, integer_only: true

  validate :date_debut_avant_date_fin
  validate :dates_non_passees
  validate :disponible

end
