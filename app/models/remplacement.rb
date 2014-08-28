class Remplacement < ActiveRecord::Base
  #strong_parameters :id_event_calendar, :id_utilisateur, :id_utilisateur_remplacant, :statut

  belongs_to :utilisateur

  validates :id_event_calendar, :id_utilisateur, :id_utilisateur_remplacant, :statut, :presence => true

  validates :id_utilisateur, :id_utilisateur_remplacant, :numericality => { :only_integer => true }
end
