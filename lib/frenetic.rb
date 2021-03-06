require 'addressable/uri'
require 'faraday'
require 'faraday_middleware'
require 'rack-cache'

require "frenetic/configuration"
require "frenetic/hal_json"
require "frenetic/resource"
require "frenetic/version"

class Frenetic

  class MissingAPIReference < StandardError; end
  class InvalidAPIDescription < StandardError; end

  extend Forwardable
  def_delegators :@connection, :get, :put, :post, :delete

  attr_reader  :connection
  alias_method :conn, :connection

  def initialize( config = {} )
    config      = Configuration.new( config )

    yield config if block_given?

    api_url     = Addressable::URI.parse( config[:url] )
    @root_url   = api_url.path

    @connection = Faraday.new( config ) do |builder|
      builder.use HalJson
      builder.request :basic_auth, config[:username], config[:password]

      builder.response :logger if config[:response][:use_logger]

      if config[:cache]
        builder.use FaradayMiddleware::RackCompatible, Rack::Cache::Context, config[:cache]
      end

      builder.adapter :patron
    end
  end

  def description
    @description ||= load_description
  end

  # A naive approach to reloading a Frenetic instance for testing purpose.
  def reload!
    instance_variables.each { |var| instance_variable_set(var, nil) }
  end

private

  def load_description
    if response = get( @root_url ) and response.success?
      response.body
    else
      raise InvalidAPIDescription, "Status code #{response.status} encountered."
    end
  end
end
