FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }  # Ensure the email is unique
    google_uid { Faker::Internet.unique.uuid }  # Ensure the google_uid is unique
    uid { Faker::Internet.unique.uuid }  # Ensure the uid is unique
    password { 'password' }
  end
end
