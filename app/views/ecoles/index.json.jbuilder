json.array!(@ecoles) do |ecole|
  json.extract! ecole, :id, :nom, :adresse, :numero_telephone
  json.url ecole_url(ecole, format: :json)
end
