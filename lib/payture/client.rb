module Payture
  class Client < Api
    Dir[File.expand_path("../client/*.rb", __FILE__)].each{|f| require f}

    include Client::Vwapi
  end
end
