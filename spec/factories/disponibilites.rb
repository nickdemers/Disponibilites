# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :disponibilite_disponible, :class => 'Disponibilite' do
    endroit_id { 11 }
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"disponible"}
    association :utilisateur_absent, factory: :utilisateur_permanent, strategy: :build
  end

  factory :disponibilite_attribue, :class => 'Disponibilite' do
    endroit_id { 11 }
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"attribue"}
    association :utilisateur_absent, factory: :utilisateur_permanent, strategy: :build
    association :utilisateur_remplacant, factory: :utilisateur_remplacant, strategy: :build
  end

  factory :disponibilite_without_dates, :class => 'Disponibilite' do
    endroit_id { 11 }
    niveau_id { 12 }
    date_heure_debut {nil}
    date_heure_fin {nil}
    statut {"attribue"}
    association :utilisateur_absent, factory: :utilisateur_permanent, strategy: :build
    association :utilisateur_remplacant, factory: :utilisateur_remplacant, strategy: :build
  end
end
