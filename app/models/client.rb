class Client < ActiveRecord::Base
  belongs_to :user

  has_many :invoices

  validates :first_name, :last_name, :company, presence: true, on: :update
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end
