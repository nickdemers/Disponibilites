# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role, :class => 'Role' do
    nom "super_admin"
  end

  factory :role_admin, :class => 'Role' do
    nom "admin"
  end

  factory :role_remplacant, :class => 'Role' do
    nom "remplacant"
  end

  factory :role_permanent, :class => 'Role' do
    nom "permanent"
  end
end