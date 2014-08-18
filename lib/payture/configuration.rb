require File.expand_path('../version', __FILE__)

module Payture
  module Configuration
    VALID_OPTIONS_KEYS = [
      :host,
      :key,
      :password,
    ].freeze


    DEFAULT_HOST = 'sandbox'
    DEFAULT_KEY = 'MerchantKey'
    DEFAULT_PASSWORD = nil

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
      self.host = DEFAULT_HOST
      self.key = DEFAULT_KEY
      self.password = DEFAULT_PASSWORD
    end
  end
end
