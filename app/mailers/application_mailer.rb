class ApplicationMailer < ActionMailer::Base
  default from: "invoice@invictus.com"
  layout 'mailer'
end
