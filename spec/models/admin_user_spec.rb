# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe AdminUser, type: :model do

  it "is not valid without parameters" do
    expect(AdminUser.new).to_not be_valid
  end

  it "is valid with email and password" do
    expect(AdminUser.new(email: Faker::Internet.email,
      password: "Test123!")).to be_valid
  end

end
