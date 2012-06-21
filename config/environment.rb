# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dcdecibel::Application.initialize!

Time::DATE_FORMATS[:long_date] = "%A, %B %d"

