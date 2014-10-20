class Utilisateur < ActiveRecord::Base
  #strong_parameters :courriel, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre

  has_many :disponibilites_absent, :foreign_key => 'utilisateur_absent_id', :class_name => 'Disponibilite'
  has_many :disponibilites_remplacant, :foreign_key => 'utilisateur_remplacant_id', :class_name => 'Disponibilite'

  validates_presence_of :courriel, :nom, :prenom, :numero_telephone, :titre
  validates_length_of :nom, :prenom, :maximum => 255
  validates :niveau, :numericality => { :only_integer => true }, :allow_blank => true

end