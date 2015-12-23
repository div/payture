require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }

module Payture
  module Connection
    private

    def connection(params = {})
      params[:raw] = false if params[:raw].nil?
      params[:auth] = true if params[:auth].nil?
      auth = params[:auth]
      raw = params[:raw]
      password_required = params[:password_required]
      options = {
          :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
          :url => host,
      }

      auth_options = {}
      auth_options.merge!(access_token: key) if auth
      auth_options.merge!(password: password) if password_required

      Faraday::Connection.new(options) do |connection|
        connection.use FaradayMiddleware::PaytureAuth, auth_options if auth
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
