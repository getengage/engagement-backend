FactoryGirl.define do
  factory :api_key do
    name Faker::Internet.url
    uuid { SecureRandom.uuid }
  end
end