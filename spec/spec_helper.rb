require 'rubygems'
require 'nokogiri'

RSpec.configure do |config|
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.color = true
end
