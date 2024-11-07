# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  email                :string
#  google_expires_at    :datetime
#  google_refresh_token :string
#  google_token         :string
#  google_uid           :string
#  name                 :string
#  profile_picture      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class User < ApplicationRecord
    validates :google_uid, uniqueness: true
    has_many :projects, dependent: :destroy
    has_many :comments, dependent: :destroy

    devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
        end
    end
end
  
