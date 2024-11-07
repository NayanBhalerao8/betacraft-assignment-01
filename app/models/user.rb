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
class User < ApplicationRecord
    validates :google_uid, uniqueness: true
    has_many :projects, dependent: :destroy
    has_many :comments, dependent: :destroy

    devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.provider = auth.provider            # Save the provider if not already set
            user.uid = auth.uid                      # Save the UID from Google
            # Set any other necessary fields here from `auth` if needed
            user.password = Devise.friendly_token[0, 20] if user.new_record?
        end
    end
          
end
  
