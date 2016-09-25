FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    email "test@example.com"
    password "please1234" # min password is 10

    trait :admin do
      role 'admin'
    end

  end
end
