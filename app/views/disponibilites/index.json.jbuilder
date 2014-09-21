json.array!(@disponibilites) do |disponibilite|
  json.extract! disponibilite, :id, :utilisateur_absent_id, :utilisateur_remplacant_id, :endroit_id, :niveau_id, :date_heure_debut, :date_heure_fin, :surveillance, :specialite, :notes, :statut, :created_at, :updated_at
  json.url disponibilite_url(disponibilite, format: :json)
end
