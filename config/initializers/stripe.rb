Stripe.api_key = nil

def using_stripe(freelancer)
  Stripe.api_key = freelancer.stripe_secret_key
  res = yield
  Stripe.api_key = nil
  res
end
