# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role, :class => 'Role' do
    nom "admin"
  end

  factory :role_remplacant, :class => 'Role' do
    nom "remplacant"
  end
end