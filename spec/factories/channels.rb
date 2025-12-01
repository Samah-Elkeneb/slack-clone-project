FactoryBot.define do
  factory :channel do
    name { "Test Channel" }
    public { false }
    association :creator, factory: :user
  end
end
