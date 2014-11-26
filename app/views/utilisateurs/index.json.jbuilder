json.array!(@utilisateurs) do |utilisateur|
  json.extract! utilisateur, :id
  json.url utilisateur_url(utilisateur, format: :json)
end
