FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name Faker::Name.name
    email Faker::Internet.email
    password "please1234" # min password is 10
    client

    trait :admin do
      role 'admin'
    end
  end
end
