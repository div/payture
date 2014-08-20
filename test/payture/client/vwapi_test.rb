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
        let(:email) { '1234567@ya.ru' }
        let(:options) { {'VWUserLgn' => email, 'VWUserPsw' => 123, 'PhoneNumber' => 79156781234 } }
        subject { client.register options }
        describe 'with new user', :vcr do
          it "returns success status" do
            VCR.use_cassette('register/new') do
              subject.success.must_equal "True"
              subject.v_w_user_lgn.must_equal email
              subject.err_code.must_be_nil
            end
          end
        end
      end

    end

    describe '.add' do
      let(:email) { 'rom@dom.com' }
      let(:options) {
        {
          v_w_user_lgn: email,
          v_w_user_psw: 123,
          phone_number: 79001234567,
          card_number: 4111111111111112,
          e_month: 12,
          e_year: 12,
          card_holder: 'Ivan Ivanov',
          secure_code: 123
        }
      }
      subject { client.add options }
      describe "request url" do
        before do
          data_string = 'VWUserLgn%3Drom%40dom.com%3BVWUserPsw%3D123%3BCardNumber%3D4111111111111112%3BEMonth%3D12%3BEYear%3D12%3BCardHolder%3DIvan+Ivanov%3BSecureCode%3D123%3BPhoneNumber%3D79001234567'
          @get = stub_get("Add")
            .with(query: {'VWID' => client.key, 'DATA' => data_string})
        end
        it 'should be correct' do
          subject
          assert_requested @get
        end
      end
      describe 'with existing user' do
      end
      describe 'with new user' do
      end
    end

  end
end
