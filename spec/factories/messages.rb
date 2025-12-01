FactoryBot.define do
  factory :message do
    association :user
    association :channel
    content { "Hello world!" }
  end
end
