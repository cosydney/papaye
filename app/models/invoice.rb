class Invoice < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :client
  has_many :transitions, class_name: "InvoiceTransition", autosave: false
  has_many :descriptions

  accepts_nested_attributes_for :client

  validates :invoice_nr, presence: true

  # def self.freelance
  #   @invoices = Freelance.invoices
  # end

# This is done to give some state to each invoice and tell the freelancer what is it.
  def state_machine
    @state_machine ||= InvoiceStateMachine.new(self, transition_class: InvoiceTransition,
                                                      association_name: :transitions)
  end

  # optionally delegating some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
          to: :state_machine
  # After the invoice gets created do:
  after_create :send_invoice_by_email

  private

  def send_invoice_by_email
    # Calling method in user_mailer.rb, for now: deliver_now (no AfterJob so far)
    UserMailer.send_invoice_client(self.id).deliver_now
  end

end
