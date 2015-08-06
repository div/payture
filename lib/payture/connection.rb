require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }

module Payture
  module Connection
    private

    def connection(raw=false, auth=true)
      options = {
          :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
          :url => host,
      }

      Faraday::Connection.new(options) do |connection|
        connection.use FaradayMiddleware::PaytureAuth, key if auth
        connection.use Faraday::Request::UrlEncoded
        connection.use FaradayMiddleware::Mashify unless raw
        connection.use FaradayMiddleware::Underscore unless raw
        unless raw
          case format.to_s.downcase
            when 'json' then
              connection.use Faraday::Response::ParseJson
            when 'xml' then
              connection.use Faraday::Response::ParseXml
          end
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
      end
    end
  end
end
