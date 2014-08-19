module Payture
  module Request

    def get(path, options={}, raw=false, unformatted=false, no_response_wrapper=false)
      request(:get, path, options, raw, unformatted, no_response_wrapper)
    end

    def post(path, options={}, raw=false, unformatted=false, no_response_wrapper=false)
      request(:post, path, options, raw, unformatted, no_response_wrapper)
    end

    def put(path, options={}, raw=false, unformatted=false, no_response_wrapper=false)
      request(:put, path, options, raw, unformatted, no_response_wrapper)
    end

    def delete(path, options={}, raw=false, unformatted=false, no_response_wrapper=false)
      request(:delete, path, options, raw, unformatted, no_response_wrapper)
    end

    private

    def request(method, path, options, raw=false, unformatted=false, no_response_wrapper=false)
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, 'DATA' => encoded_string(options))
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end
      return response if raw
      return response.body if no_response_wrapper
      return Response.create( response.body )
    end

    def encoded_string hash
      s = hash.map{|k,v| "#{k}=#{v}"}.join(';')
      CGI.escape s
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end
  end
end
