require File.expand_path("../../../test_helper", __FILE__)

module Payture
  describe Client do

    before do
      @client = Client.new
    end

    describe ".register" do

      # before do
      #   @stubbed_get = stub_get("exchanges/#{id}.#{format}").
      #   with(query: {token: @client.token}).
      #   to_return(body: fixture("exchange.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
      # end

      # it "should get the correct resource" do
      #   @client.exchange(id)
      #   assert_requested @register
      # end

      it "returns status" do
        response = @client.register
        puts response.inspect
        response.success.must_equal "False"
      end

    end

  end
end
