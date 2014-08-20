require 'payture'
require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'webmock/minitest'
require "vcr"
# require "minitest-vcr"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
  # c.hook_into :faraday
end

# MinitestVcr::Spec.configure!

def stub_get(path)
  stub_request(:get, Payture.host + path)
end