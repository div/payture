module Payture
  module Response
    def self.create( response_hash )
      data = response_hash.data.dup rescue response_hash.dup
      data.extend( self )
      data
    end
  end
end
