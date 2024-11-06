AdminUser.destroy_all

puts "Create Admin users"

AdminUser.create!(
  email: 'admin@betacraft.io',
  password: '123123123',
  password_confirmation: '123123123'
)

AdminUser.create!(
  email: 'admin2@betacraft.io',
  password: '123123123',
  password_confirmation: '123123123'
)

AdminUser.create!(
  email: 'admin@example.com',
  password: 'beta123',
  password_confirmation: 'beta123'

)