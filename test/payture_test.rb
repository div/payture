require File.expand_path("../test_helper", __FILE__)

describe Payture do
  it "is valid" do
    Payture.must_be_kind_of Module
  end

  it 'has host' do
    Payture.host.must_equal 'https://sandbox.payture.com/vwapi/'
  end

  it 'converts to underscore' do
    Payture.convert_to_underscore('AssDf').must_equal 'ass_df'
  end
end