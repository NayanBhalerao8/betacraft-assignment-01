after :admin_users do
  User.destroy_all

  puts "Create Users"

  User.create!(
    email: 'user1@betacraft.io',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '123123123',
    password_confirmation: '123123123'
  )

  User.create!(
    email: 'user2@betacraft.io',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '123123123',
    password_confirmation: '123123123'
  )

  User.create!(
    email: 'user@example.com',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'beta123',
    password_confirmation: 'beta123'
  )

end
