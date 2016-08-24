class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  attr_accessor :virtual_data, :invitation_instructions

  has_one :freelancer, dependent: :destroy
  has_one :client, dependent: :destroy
  after_create :my_create_association, unless: proc { |u| u.client } # unless :is_client # add if statement for client

  def self.invite_client!(attributes={}, invited_by=nil, options={})
    Invoice.find(options[:invoice_id]).log_activity :sent
    self.invite!(attributes, invited_by, options) do |user|
      user.invitation_instructions = :client_invitation_instructions
      user.build_client(email: user.email)
    end
  end

  def my_create_association
    if virtual_data.nil?
      create_freelancer
    else
      create_freelancer(
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


