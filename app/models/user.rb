require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  has_and_belongs_to_many :roles

  has_many :demandes

  #before_destroy :check_user_in_disponibilite

  #def check_user_in_disponibilite
  #  return false if Disponibilite.find_by_user_absent_id(id)
  #  return false if Disponibilite.find_by_user_remplacant_id(id)
  #end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :disponibilites_absent, :foreign_key => 'user_absent_id', :class_name => 'Disponibilite', :dependent => :restrict_with_exception
  has_many :disponibilites_remplacant, :foreign_key => 'user_remplacant_id', :class_name => 'Disponibilite', :dependent => :restrict_with_exception

  validates_presence_of :nom, :prenom, :numero_telephone, :titre
  validates_length_of :nom, :prenom, :maximum => 255
  validates :niveau, :numericality => { :only_integer => true }, :allow_blank => true

  scope :join_disponibilite_by_user_remplacant, -> { joins("LEFT JOIN disponibilites on disponibilites.user_remplacant_id = users.id") }

  scope :by_next_user_remplacant_available, -> date_heure_debut, date_heure_fin { where(["users.id not in (select COALESCE(user_remplacant_id,0) from disponibilites where (? between disponibilites.date_heure_debut and disponibilites.date_heure_fin) or (? between disponibilites.date_heure_debut and disponibilites.date_heure_fin))", date_heure_debut, date_heure_fin]) }

  scope :by_user_not_in_demande_with_dispo_id, -> disponibilite_id {where(["users.id not in (select COALESCE(user_id,0) from demandes where disponibilite_id = ?)", disponibilite_id]) if disponibilite_id}

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

  def self.find_by_next_user_remplacant_available(date_time_start, date_time_end, disponibilite_id)
    where(titre: 'remplacant').order("id").by_next_user_remplacant_available(date_time_start, date_time_end).by_user_not_in_demande_with_dispo_id(disponibilite_id).first
  end
end