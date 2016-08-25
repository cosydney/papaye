source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.6'
gem 'puma'
gem 'pg'
gem 'figaro'
gem 'jbuilder', '~> 2.0'
gem 'devise'
gem 'devise_invitable', '~> 1.7.0'
gem 'redis'
# Background jobs
gem 'sidekiq'
gem 'sinatra'  # Dependency for the Sidekiq Dashboard
gem 'sidekiq-failures'
#  ---
# Admin interface
gem 'remotipart', github: 'mshibuya/remotipart'
gem 'rails_admin', '>= 1.0.0.rc'
#  ---
# Newsfeed
gem 'public_activity'
# PDF downloader from html file
gem 'wicked_pdf'
# wrapper for wkhtmltopdf (part of the pdf downloader)
gem 'wkhtmltopdf-binary'


gem 'sass-rails'
gem 'jquery-rails'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'autoprefixer-rails'
gem "omniauth-google-oauth2"
gem 'statesman', '~> 2.0', '>= 2.0.1'

# Stripe
gem 'money-rails'
gem 'stripe'

# Invoice form validations
gem "parsley-rails"
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'

# Nested form
gem "cocoon"

group :development, :test do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring'
  gem 'letter_opener'

end

gem 'rails_12factor', group: :production
