class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  attr_accessor :virtual_data, :invitation_instructions

  has_one :freelancer
  has_one :client
  after_create :my_create_freelancer # unless :is_client # add if statement for client

  def self.invite_client!(attributes={}, invited_by=nil, options={})
    puts attributes
    puts invited_by
    puts options
    self.invite!(attributes, invited_by, options) do |invitable|
      invitable.invitation_instructions = :client_invitation_instructions
    end
  end


  def my_create_freelancer
    if virtual_data.nil?
      self.create_freelancer
    else
      self.create_freelancer(
        first_name: self.virtual_data[:first_name],
        last_name: self.virtual_data[:last_name]
        )
    end
  end

  def self.create_user_and_freelancer(data)
    user = User.new(
      email: data["email"],
      password: Devise.friendly_token[0,20],
      virtual_data: data
      )
    user.save
    user
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data[:email]).first

    # Uncomment the section below if you want users to be created if they don't exist
    user = create_user_and_freelancer(data) unless user
    user
  end

  def is_client
    false
    # here we should say if the user created is a client
  end
end




# invoice
# belongs_to 'freelance', class_name :user
# belongs_to 'client', class_name :user

