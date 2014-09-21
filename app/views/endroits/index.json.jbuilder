json.array!(@endroits) do |endroit|
  json.extract! endroit, :id, :nom, :adresse, :numero_telephone, :created_at, :updated_at
  json.url endroit_url(endroit, format: :json)
end
