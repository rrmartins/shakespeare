require 'rubygems'
require 'nokogiri'
require 'byebug'
require './app/analyser.rb'

RSpec.configure do |config|
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.color = true
end
