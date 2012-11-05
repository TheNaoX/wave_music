FactoryGirl.define do
  factory :user do
    username 'UserMoxito'
    email 'user@example.com'
    password 'supersecret'
    password_confirmation 'supersecret'
  end
end
