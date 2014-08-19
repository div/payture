require File.expand_path('../payture/configuration', __FILE__)
require File.expand_path('../payture/api', __FILE__)
require File.expand_path('../payture/client', __FILE__)
require File.expand_path('../payture/error', __FILE__)

module Payture
  extend Configuration

  def self.client(options={})
    Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end

end
