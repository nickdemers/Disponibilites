# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :disponibilite_disponible, :class => 'Disponibilite' do
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"available"}
    association :user_absent, factory: :user_permanent, strategy: :build
    association :ecole, factory: :ecole_test#, strategy: :build
  end

  factory :disponibilite_disponible_with_remplacant, :class => 'Disponibilite' do
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"available"}
    association :user_absent, factory: :user_permanent, strategy: :build
    association :user_remplacant, factory: :user_remplacant, strategy: :build
    association :ecole, factory: :ecole_test#, strategy: :build
  end

  factory :disponibilite_attribue, :class => 'Disponibilite' do
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"assigned"}
    association :user_absent, factory: :user_permanent, strategy: :build
    association :user_remplacant, factory: :user_remplacant, strategy: :build
    association :ecole, factory: :ecole#, strategy: :build
  end

  factory :disponibilite_attribue_with_same_remplacant, :class => 'Disponibilite' do
    niveau_id { 12 }
    date_heure_debut {DateTime.now + 1.minute}
    date_heure_fin {DateTime.now + 1.hour}
    statut {"assigned"}
    association :user_absent, factory: :user_permanent2, strategy: :build
    association :user_remplacant, factory: :user_remplacant, strategy: :build
    association :ecole, factory: :ecole#, strategy: :build
  end

  factory :disponibilite_without_dates, :class => 'Disponibilite' do
    niveau_id { 12 }
    date_heure_debut {nil}
    date_heure_fin {nil}
    statut {"assigned"}
    association :user_absent, factory: :user_permanent, strategy: :build
    association :user_remplacant, factory: :user_remplacant, strategy: :build
    association :ecole, factory: :ecole#, strategy: :build
  end
end
