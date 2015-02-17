# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :utilisateur_permanent, :class => 'Utilisateur' do
    id {1}
    email {"nickdemers_permanent@gmail.com"}
    nom {"Demers permanent"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
    password {"12345678"}
  end

  factory :utilisateur_permanent2, :class => 'Utilisateur' do
    id {4}
    email {"nickdemers_permanent2@gmail.com"}
    nom {"Demers permanent2"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
    password {"12345678"}
  end

  factory :utilisateur_remplacant, :class => 'Utilisateur' do
    id {2}
    email {"nickdemers_remplacant@gmail.com"}
    nom {"Demers remplacant"}
    prenom {"Nicolas"}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
    password {"12345678"}
  end

  factory :utilisateur_remplacant2, :class => 'Utilisateur' do
    id {5}
    email {"nickdemers_remplacant2@gmail.com"}
    nom {"Demers remplacant2"}
    prenom {"Nicolas"}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
    password {"12345678"}
  end

  factory :utilisateur_remplacant_without_names, :class => 'Utilisateur' do
    id {3}
    email {"nickdemers_remplacant2@gmail.com"}
    nom {}
    prenom {}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
    password {"12345678"}
  end

  factory :utilisateur, :class => 'Utilisateur' do
    id {1}
    email {"nickdemers_permanent@gmail.com"}
    nom {"Demers permanent"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
    password {"12345678"}
    association :roles, factory: [:role]#, strategy: :build
    #association :roles, [factory: :role]#, strategy: :build
  end

end

Factory.define :utilisateur_is_admin, :parent => :utilisateur do |utilisateur|
  utilisateur.after_create { |l| Factory(:role, :role => l)  }
  #or some for loop to generate X features
end
