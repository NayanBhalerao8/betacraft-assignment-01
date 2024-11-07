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
class User < ApplicationRecord
    validates :google_uid, uniqueness: true
    has_many :projects, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :uid, uniqueness: { scope: :provider, message: "has already been taken" }

    devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

    # def self.from_omniauth(auth)
    #     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #         user.email = auth.info.email
    #         user.provider = auth.provider            # Save the provider if not already set
    #         user.uid = auth.uid                      # Save the UID from Google
    #         # Set any other necessary fields here from `auth` if needed
    #         user.password = Devise.friendly_token[0, 20] if user.new_record?
    #     end
    # end
    def self.from_omniauth(auth)
        # Find user by provider and uid first
        user = User.find_by(provider: auth.provider, uid: auth.uid)
      
        # If user is not found, try finding by email
        user ||= User.find_by(email: auth.info.email)
      
        # If user exists but does not have a uid, update it
        if user
          user.update(uid: auth.uid, google_uid: auth.uid) unless user.uid && user.google_uid
        else
          # Create new user if none exists
          user = User.create!(
            email: auth.info.email,
            uid: auth.uid,
            google_uid: auth.uid,
            provider: auth.provider,
            password: Devise.friendly_token[0, 20]
          )
        end
      
        user
    end
      
      
          
end
  
