class Disponibilite < ActiveRecord::Base
  include DisponibiliteValidations

  belongs_to :ecole, :validate => true

  belongs_to :user_absent, :class_name => 'User'
  belongs_to :user_remplacant, :class_name => 'User'

  has_many :demandes

  validates_presence_of :user_absent_id, :date_heure_debut, :date_heure_fin, :statut, :niveau_id, :ecole_id
  validates_numericality_of :niveau_id, :ecole_id, integer_only: true, allow_nil: true

  validate :date_debut_avant_date_fin
  validate :dates_non_passees
  validate :disponible

  scope :by_date_debut, -> date_debut { where("date_heure_debut >= ?", date_debut) unless date_debut.blank? }
  scope :by_date_fin, -> date_fin { where("date_heure_fin <= ?", date_fin) unless date_fin.blank? }
  scope :by_user_absent, -> user_absent_id { where(user_absent_id: user_absent_id) unless user_absent_id.blank? }
  scope :by_user_remplacant, -> user_remplacant_id { where(user_remplacant_id: user_remplacant_id) unless user_remplacant_id.blank? }
  scope :order_by_date_heure_debut, -> { order("date_heure_debut") }
  scope :by_statut_waiting_available, -> { where("(statut = 'waiting' or statut = 'available')") }
  scope :by_between_date_debut_fin, -> date_debut, date_fin { where("date_heure_debut between ? and ?", date_debut, date_fin) }

end
