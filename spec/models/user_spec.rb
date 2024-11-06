# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without parameters" do
    expect(User.new).to_not be_valid
  end

  it "is not valid without email and password" do
    expect(User.new(first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name)).to_not be_valid
  end

  it "is valid with email and password" do
    expect(User.new(email: Faker::Internet.email,
      password: "Test123!")).to be_valid
  end

  it "is valid with all parameters" do
    expect(
      User.new(
        email: Faker::Internet.email,
        password: "Test123!",
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    ).to be_valid
  end
end
