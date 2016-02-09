FactoryGirl.define do
  factory :demande do
    association :user, factory: :user_remplacant, strategy: :build
    association :disponibilite, factory: :disponibilite_disponible, strategy: :build
    priority 1
    status "MyString"
  end

end
