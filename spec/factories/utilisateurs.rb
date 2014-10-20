# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :utilisateur_permanent, :class => 'Utilisateur' do
    courriel {"nickdemers@gmail.com"}
    nom {"Demers permanent"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
  end

  factory :utilisateur_remplacant, :class => 'Utilisateur' do
    courriel {"nickdemers@gmail.com"}
    nom {"Demers remplacant"}
    prenom {"Nicolas"}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
  end
end
