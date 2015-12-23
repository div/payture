require 'faraday'

module FaradayMiddleware
  class PaytureAuth < Faraday::Middleware
    def call(env)

      if env[:url].query.nil?
        query = {}
      else
        query = Faraday::Utils.parse_query(env[:url].query)
      end

      auth_params = {}

      if @access_token
        auth_params.merge!('VWID' => @access_token)
      end

      if @password
        auth_params.merge!('Password' => @password)
      end
      env[:url].query = Faraday::Utils.build_query(query.merge(auth_params))
      @app.call env
    end

    def initialize(app, params = {})
      @app = app
      @access_token = params[:access_token]
      @password = params[:password]
    end
  end
end
