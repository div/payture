require 'faraday'

module FaradayMiddleware
  class PaytureAuth < Faraday::Middleware
    def call(env)

      if env[:url].query.nil?
        query = {}
      else
        query = Faraday::Utils.parse_query(env[:url].query)
      end

      if @access_token
        env[:url].query = Faraday::Utils.build_query(query.merge('VWID' => @access_token))
      end

      @app.call env
    end

    def initialize(app, access_token=nil)
      @app = app
      @access_token = access_token
    end
  end
end
