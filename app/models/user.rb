# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  google_uid      :string
#  name            :string
#  profile_picture :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :google_uid, uniqueness: true
    has_many :projects, dependent: :destroy
    has_many :comments, dependent: :destroy
end
