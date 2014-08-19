require 'faraday'
require File.expand_path('../version', __FILE__)

module Payture
  module Configuration

    DOMAIN = 'payture.com'

    VALID_OPTIONS_KEYS = [
      :api_type,
      :host_type,
      :key,
      :password,
      :format,
      :user_agent,
      :adapter
    ].freeze


    DEFAULT_API_TYPE = 'vwapi'
    DEFAULT_HOST_TYPE = 'sandbox'
    DEFAULT_KEY = 'MerchantKey'
    DEFAULT_PASSWORD = nil
    DEFAULT_USER_AGENT = "Payture Ruby Gem #{Payture::VERSION}".freeze
    DEFAULT_FORMAT = 'xml'
    DEFAULT_ADAPTER = Faraday.default_adapter

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter = DEFAULT_ADAPTER
      self.api_type = DEFAULT_API_TYPE
      self.host_type = DEFAULT_HOST_TYPE
      self.key = DEFAULT_KEY
      self.password = DEFAULT_PASSWORD
      self.user_agent = DEFAULT_USER_AGENT
      self.format = DEFAULT_FORMAT
    end
  end
end
