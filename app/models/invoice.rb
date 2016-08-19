class Invoice < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :client
  validates :invoice_nr, presence: true

  has_many :descriptions

  accepts_nested_attributes_for :client
  # After the invoice gets created do:
  after_create :send_invoice_by_email

  private

  def send_invoice_by_email
    # calling method in user_mailer.rb, for now: delicer_now (no AfterJob so far)
    UserMailer.send_invoice_client(self.id).deliver_now
  end


end
