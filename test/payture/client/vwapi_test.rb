require File.expand_path("../../../test_helper", __FILE__)

module Payture
  describe Client do


    let(:client) { Client.new }

    describe ".register" do

      let(:options) { {'VWUserLgn' => '123@ya.ru', 'VWUserPsw' => 123, 'PhoneNumber' => 79156783333 } }
      subject { client.register options }

      describe 'follow doc example' do

        describe "url" do
          before do
            data_string = 'VWUserLgn%3D123%40ya.ru%3BVWUserPsw%3D123%3BPhoneNumber%3D79156783333'
            @get = stub_get("Register")
              .with(query: {'VWID' => client.key, 'DATA' => data_string})
          end
          it 'should be correct' do
            subject
            assert_requested @get
          end
        end

        describe 'body' do
          it "returns status" do
            VCR.use_cassette('register/duplicate') do
              subject.success.must_equal "False"
              subject.err_code.must_equal "DUPLICATE_USER"
            end
          end
        end
      end

      describe 'using real credentials' do
        # let(:client) { Client.new key: 'MerchantQlean' }
        let(:options) { {'VWUserLgn' => '1234567@ya.ru', 'VWUserPsw' => 123, 'PhoneNumber' => 79156781234 } }
        subject { client.register options }
        describe 'with new user', :vcr do
          it "returns success status" do
            VCR.use_cassette('register/new') do
              subject.success.must_equal "True"
              subject.err_code.must_be_nil
            end
          end
        end
      end

    end

  end
end
