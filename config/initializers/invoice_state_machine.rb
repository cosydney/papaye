class InvoiceStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :pending
  state :captured
  state :paid
  state :finished_mission
  state :refused

  transition from: :draft, to:[:pending]
  transition from: :pending, to:[:captured, :paid, :refused]
  transition from: :captured, to:[:paid, :refused]
  transition from: :paid, to:[:finished_mission]


  ############ Possibility to set email after some transitions and some more stuff

  # guard_transition(to: :checking_out) do |order|
  #   order.products_in_stock?
  # end

  # before_transition(from: :checking_out, to: :cancelled) do |order, transition|
  #   order.reallocate_stock
  # end

  # before_transition(to: :purchased) do |order, transition|
  #   PaymentService.new(order).submit
  # end

  # after_transition(to: :purchased) do |order, transition|
  #   MailerService.order_confirmation(order).deliver
  # end

end