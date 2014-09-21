class Disponibilite < ActiveRecord::Base
  has_one :endroit
  has_one :niveau
  has_one :utilisateur_absent, :class_name => 'Utilisateur', :primary_key => 'utilisateur_id'
  has_one :utilisateur_remplacant, :class_name => 'Utilisateur', :primary_key => 'utilisateur_id'
end
