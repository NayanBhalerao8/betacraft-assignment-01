# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  avatar_url           :string
#  email                :string
#  encrypted_password   :string
#  full_name            :string
#  google_expires_at    :datetime
#  google_refresh_token :string
#  google_token         :string
#  google_uid           :string
#  name                 :string
#  profile_picture      :string
#  provider             :string
#  remember_created_at  :datetime
#  uid                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_google_uid        (google_uid) UNIQUE
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
