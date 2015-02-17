FactoryGirl.define do
  factory :ecole, :class => 'Ecole' do
    nom "École test"
    adresse "123 rue finfin"
    numero_telephone "418 999-8888"
  end

  factory :ecole_test, :class => 'Ecole' do
    nom "École test"
    adresse "123 rue finfin"
    numero_telephone "418 999-8888"
  end

end
