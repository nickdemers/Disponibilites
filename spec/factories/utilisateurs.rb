# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :utilisateur_permanent, :class => 'Utilisateur' do
    id {1}
    courriel {"nickdemers@gmail.com"}
    nom {"Demers permanent"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
  end

  factory :utilisateur_remplacant, :class => 'Utilisateur' do
    id {2}
    courriel {"nickdemers@gmail.com"}
    nom {"Demers remplacant"}
    prenom {"Nicolas"}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
  end

  factory :utilisateur_remplacant_without_names, :class => 'Utilisateur' do
    id {3}
    courriel {"nickdemers@gmail.com"}
    nom {}
    prenom {}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
  end
end
