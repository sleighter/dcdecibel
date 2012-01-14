# Load the rails application
require File.expand_path('../application', __FILE__)

config.action_mailer.default_url_options = { :host => 'dcdecibel.heroku.com' }

# Initialize the rails application
Dcdecibel::Application.initialize!
