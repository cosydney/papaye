class Freelancer < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :invoices

end
