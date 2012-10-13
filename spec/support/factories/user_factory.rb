FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'supersecret'
    password_confirmation 'supersecret'
  end
end
