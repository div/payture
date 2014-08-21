module Payture
  module Helper
    def self.convert_to_underscore(key)
      key.scan(/[A-Z][a-z]*/).join("_").downcase
    end
  end
end