# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_permanent, :class => 'User' do
    id {1}
    email {"nickdemers_permanent@gmail.com"}
    nom {"Demers permanent"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
    password {"12345678"}
  end

  factory :user_permanent2, :class => 'User' do
    id {4}
    email {"nickdemers_permanent2@gmail.com"}
    nom {"Demers permanent2"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
    password {"12345678"}
  end

  factory :user_remplacant, :class => 'User' do
    id {2}
    email {"nickdemers_remplacant@gmail.com"}
    nom {"Demers remplacant"}
    prenom {"Nicolas"}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
    password {"12345678"}
  end

  factory :user_remplacant2, :class => 'User' do
    id {5}
    email {"nickdemers_remplacant2@gmail.com"}
    nom {"Demers remplacant2"}
    prenom {"Nicolas"}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
    password {"12345678"}
  end

  factory :user_remplacant_without_names, :class => 'User' do
    id {3}
    email {"nickdemers_remplacant2@gmail.com"}
    nom {}
    prenom {}
    numero_telephone {"418 777-7777"}
    titre {"remplacant"}
    password {"12345678"}
  end

  factory :user_admin, :class => 'User' do
    id {1}
    email {"nickdemers_permanent@gmail.com"}
    nom {"Demers permanent"}
    prenom {"Nicolas"}
    numero_telephone {"418 999-9999"}
    titre {"permanent"}
    password {"12345678"}
    #association :roles, factory: [:role]#, strategy: :build
    #association :roles, [factory: :role]#, strategy: :build
  end

end
