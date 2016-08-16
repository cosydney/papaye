class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_one :freelance
  has_one :client

def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )

        user.create_freelance(
          first_name: data["first_name"],
          last_name: data["last_name"],

          )
    end
    user
end
end


# user
# type 'freelance'/'client'

# invoice
# belongs_to 'freelance', class_name :user
# belongs_to 'client', class_name :user