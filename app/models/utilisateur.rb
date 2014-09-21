class Utilisateur < ActiveRecord::Base
  #strong_parameters :courriel, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre

  #has_many :remplacements, :dependent => :restrict
  #has_many :remplacements
  has_many :disponibilites

  validates_presence_of :courriel, :nom, :prenom, :numero_telephone, :titre
  validates_length_of :nom, :prenom, :maximum => 255
  validates :niveau, :numericality => { :only_integer => true }, :allow_blank => true

end