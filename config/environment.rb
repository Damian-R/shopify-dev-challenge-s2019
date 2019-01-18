# Load the Rails application.
require_relative 'application'

if Rails.env.development?
  ENV['DISCOUNT_CODE'] ||= 'chara'
  ENV['DISCOUNT_AMOUNT'] ||= '10'
end

# Initialize the Rails application.
Rails.application.initialize!
