require "dotenv/load"
require "sinatra"
require "json"
require "nokogiri"
require "./alexa/response"
require "alexa_rubykit"
require "bundler/setup"
require "byebug" if settings.development?

use Rack::Logger

helpers do
  def logger
    request.logger
  end
end

configure do
  enable :logging
  $stdout.sync = true
  set :protection, :except => [:json_csrf]
end

before do
  content_type('application/json')
end

get "/" do
  "Simple Rest Service for Amazon Alexa Skill"
end

post "/" do
  begin
    # puts "Received request with headers:\n#{request.env.inspect}"
    request_json = JSON.parse(request.env["rack.input"].read)
    raise ArgumentError, "Application Id is invalid" unless request_json["session"]["application"]["applicationId"] == ENV['APPLICATION_ID']
    puts "Received request body:\n#{request_json.inspect}"

    alexa_request = AlexaRubykit.build_request(request_json)
    alexa_session = alexa_request.session
    alexa_response = AlexaRubykit::Response.new
    Alexa::Response.instance.make_response(alexa_request, alexa_response)
    response = alexa_response.build_response
    puts "Response: #{response.inspect}"

    response
  rescue Exception => e
    logger.error("Exception: #{e.inspect}")
    puts "Exception: #{e.inspect}"
    alexa_response = AlexaRubykit::Response.new
    alexa_response.add_speech("There was something wrong.", true)
    alexa_response.build_response
  end
end
