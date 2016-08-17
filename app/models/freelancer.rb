class Freelancer < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :invoices
# black list approach for params
  def self.unprotected_attrs
    new.attributes.symbolize_keys.keys - [:id, :user_id]
  end
end
