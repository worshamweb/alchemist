$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'alchemist'
require 'bourne'

RSpec.configure do |config|
  config.mock_with :mocha
  config.color_enabled = true
end
