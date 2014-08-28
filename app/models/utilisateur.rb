class Utilisateur < ActiveRecord::Base
  #strong_parameters :courriel, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre

  has_many :remplacements, :dependent => :restrict

  validates :courriel, :nom, :prenom, :numero_telephone, :titre, :presence => true
  validates :nom, :prenom, :length => { :maximum => 255 }
  validates :niveau, :numericality => { :only_integer => true }, :allow_blank => true

end
