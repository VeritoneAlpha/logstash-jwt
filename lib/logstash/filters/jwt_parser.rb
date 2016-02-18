# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "jwt"

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Example < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "jwt_parser"
  
  # Replace the message with this value.
  config :token, :validate => :string
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)
    @logger.warn("jwt_parser filter: reveived event", :type => event["type"])
    

#    payload = {:data => 'test'}
    
    # IMPORTANT: set nil as password parameter
#    token = JWT.encode payload, nil, 'none'

    decoded_token = JWT.decode token, nil, false
    event['token'] = decoded_token
#    puts decoded_token

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example
