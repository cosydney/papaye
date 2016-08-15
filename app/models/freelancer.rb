class Freelancer < ActiveRecord::Base
  belongs_to :user

  has_many :invoices
end
