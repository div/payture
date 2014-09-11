require File.expand_path('../../helper', __FILE__)

module Payture
  class Client
    module Vwapi

      API_METHODS = %w(Register Update Delete Add Activate Remove GetList Pay Refund PayStatus Init)

      API_METHODS.each do |method_name|
        underscore_method_name = Payture::Helper.convert_to_underscore method_name
        define_method underscore_method_name do |options|
          options ||= {}
          response = get(method_name, options)
          response.send(underscore_method_name)
        end
      end

      def charge options={}
        options = hash_to_camelcase(options)
        response = connection(false).get do |request|
          request.url('Charge', options)
        end
        return Response.create(response.body).charge
      end

    end
  end
end
