class Client < ActiveRecord::Base
  belongs_to :user
  has_many :invoices

  validates :first_name, :last_name, :company
  validates :company_number, uniqueness: true
end
