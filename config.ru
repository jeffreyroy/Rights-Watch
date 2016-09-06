# ENV setup
require 'dotenv'
Dotenv.load
# AUTH_TOKEN = ENV['SECRET_TOKEN']


# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

run Sinatra::Application
