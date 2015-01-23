require 'bcrypt'

class Utilisateur < ActiveRecord::Base

  include BCrypt

  has_and_belongs_to_many :roles

  #before_destroy :check_utilisateur_in_disponibilite

  #def check_utilisateur_in_disponibilite
  #  return false if Disponibilite.find_by_utilisateur_absent_id(id)
  #  return false if Disponibilite.find_by_utilisateur_remplacant_id(id)
  #end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  #strong_parameters :email, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre

  #belongs_to :disponibilites_absent, :class_name => 'Disponibilite', :foreign_key => 'utilisateur_absent_id'
  #belongs_to :disponibilites_remplacant, :class_name => 'Disponibilite', :foreign_key => 'utilisateur_remplacant_id'
  has_many :disponibilites_absent, :foreign_key => 'utilisateur_absent_id', :class_name => 'Disponibilite', :dependent => :restrict_with_exception
  has_many :disponibilites_remplacant, :foreign_key => 'utilisateur_remplacant_id', :class_name => 'Disponibilite', :dependent => :restrict_with_exception

  validates_presence_of :nom, :prenom, :numero_telephone, :titre
  validates_length_of :nom, :prenom, :maximum => 255
  validates :niveau, :numericality => { :only_integer => true }, :allow_blank => true

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def role?(nom_role)
    if !nom_role.nil?
      return self.roles.find_by_nom(nom_role.to_s.camelize)
    else
      return nil
    end
  end

  def self.authenticate(email, password)
    utilisateur = find_by_email(email)
    return nil  if utilisateur.nil?
    return utilisateur if utilisateur.valid_password?(password)
  end
end