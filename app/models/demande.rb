class Demande < ActiveRecord::Base
  belongs_to :user
  belongs_to :disponibilite

  validates_presence_of :user, :disponibilite
end
