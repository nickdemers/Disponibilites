json.array!(@niveaus) do |niveau|
  json.extract! niveau, :id, :nom, :created_at, :updated_at
  json.url niveau_url(niveau, format: :json)
end
