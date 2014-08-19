require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)
require File.expand_path('../response', __FILE__)

module Payture
  class Api
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = Payture.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Connection
    include Request

    protected

      def host
        "https://#{host_type}.#{Configuration::DOMAIN}/#{api_type}"
      end
  end
end
