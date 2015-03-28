require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  has_and_belongs_to_many :roles

  #before_destroy :check_user_in_disponibilite

  #def check_user_in_disponibilite
  #  return false if Disponibilite.find_by_user_absent_id(id)
  #  return false if Disponibilite.find_by_user_remplacant_id(id)
  #end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  #strong_parameters :email, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre

  has_many :disponibilites_absent, :foreign_key => 'user_absent_id', :class_name => 'Disponibilite', :dependent => :restrict_with_exception
  has_many :disponibilites_remplacant, :foreign_key => 'user_remplacant_id', :class_name => 'Disponibilite', :dependent => :restrict_with_exception

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
      return self.roles.find_by_nom(nom_role.to_s)
    else
      return nil
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.valid_password?(password)
  end
end