class Invoice < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :client
  has_many :transitions, class_name: "InvoiceTransition", autosave: false
  has_many :descriptions

  accepts_nested_attributes_for :client

  validates :invoice_nr, presence: true

# This is done to give some state to each invoice and tell the freelancer what is it.
  def state_machine
    @state_machine ||= InvoiceStateMachine.new(self, transition_class: InvoiceTransition,
                                                     association_name: :transitions)
  end

  # optionally delegating some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
          to: :state_machine
end
