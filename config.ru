# ENV setup
require 'dotenv'
Dotenv.load

require_relative 'app/models/cl_opinion'

# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

run Sinatra::Application
