class Freelancer < ActiveRecord::Base
  belongs_to :user
  has_many :invoices
  after_validation :set_email_text, on: :create



  # black list approach for params
  def self.unprotected_attrs
    new.attributes.symbolize_keys.keys - [:id, :user_id]
  end


  def set_email_text
    self.email_text =
    "Like we agreed you will find here a copy of the invoice to be paid.  Click on the button below to be redirected for the payment. This will secure the money until the mission is finished, thanks to Papaye.

Look forward to start the mission
 Thank you,
#{full_name} "
  end

  def full_name
    [first_name, last_name].join(" ")
  end



end
