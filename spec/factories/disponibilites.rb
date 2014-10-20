# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :disponibilite_disponible, :class => 'Disponibilite' do
    endroit_id { 11 }
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"disponible"}
    #utilisateur_absent {11}
    association :utilisateur_absent, factory: :utilisateur_permanent
  end

  factory :disponibilite_attribue, :class => 'Disponibilite' do
    endroit_id { 11 }
    niveau_id { 12 }
    date_heure_debut {DateTime.current}
    date_heure_fin {DateTime.current + 1.hour}
    statut {"attribue"}
    utilisateur_absent_id {13}
    utilisateur_remplacant_id {14}
    association :utilisateur_absent, factory: :utilisateur_permanent
    association :utilisateur_remplacant, factory: :utilisateur_remplacant
  end
end
