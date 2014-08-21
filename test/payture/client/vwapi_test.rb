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
        describe 'with new user' do
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
      let(:email) { 'rom1@dom.com' }
      let(:card_number) { 4111111111111112 }
      let(:options) {
        {
          v_w_user_lgn: email,
          v_w_user_psw: 123,
          card_number: card_number,
          e_month: 12,
          e_year: 15,
          card_holder: 'Ivan Ivanov',
          secure_code: 123,
          phone_number: 79001234567,
        }
      }
      subject { client.add options }
      describe "request url" do
        before do
          data_string = 'VWUserLgn%3Drom1%40dom.com%3BVWUserPsw%3D123%3BCardNumber%3D4111111111111112%3BEMonth%3D12%3BEYear%3D15%3BCardHolder%3DIvan+Ivanov%3BSecureCode%3D123%3BPhoneNumber%3D79001234567'
          @get = stub_get("Add")
            .with(query: {'VWID' => client.key, 'DATA' => data_string})
        end
        it 'should be correct' do
          subject
          assert_requested @get
        end
      end
      # describe 'with existing user' do
      #   it "returns success status" do
      #     VCR.use_cassette('add/existing') do
      #       subject.success.must_equal "True"
      #       subject.v_w_user_lgn.must_equal email
      #       subject.err_code.must_be_nil
      #     end
      #   end
      # end
      describe 'with new user' do
        describe 'with existing card' do
          it "returns success status" do
            VCR.use_cassette('add/new_user/existing_card') do
              subject.success.must_equal "False"
            end
          end
          it 'returns user login' do
            VCR.use_cassette('add/new_user/existing_card') do
              subject.v_w_user_lgn.must_equal email
            end
          end
          it 'returns error code' do
            VCR.use_cassette('add/new_user/existing_card') do
              subject.err_code.must_equal 'DUPLICATE_CARD'
            end
          end
        end
        describe 'with new card' do
          let(:email) { 'fucker1@dom.com' }
          let(:card_number) { 4111111111111112 }

          it "returns success status" do
            VCR.use_cassette('add/new_user/new_card') do
              subject.success.must_equal "True"
            end
          end
          it 'returns user login' do
            skip 'payture bug'
            VCR.use_cassette('add/new_user/new_card') do
              subject.v_w_user_lgn.must_equal email
            end
          end
          it 'returns empty error code' do
            VCR.use_cassette('add/new_user/new_card') do
              subject.err_code.must_be_nil
            end
          end
          it 'returns payture card_id' do
            VCR.use_cassette('add/new_user/new_card') do
              subject.card_id.wont_be_nil
            end
          end
        end
      end
    end

    describe '.activate' do
      let(:email) { 'fucker1@dom.com' }
      let(:card_id) { "e43544ba-cf4f-4702-85ef-313df89577eb" }
      let(:options) {
        {
          v_w_user_lgn: email,
          v_w_user_psw: 123,
          card_id: card_id,
          amount: '100',
        }
      }
      subject { client.activate options }

      describe 'with correct data' do

        it "returns success status" do
          VCR.use_cassette('activate/existing_user/existing_card') do
            subject.success.must_equal "True"
          end
        end

        it 'returns user login' do
          VCR.use_cassette('activate/existing_user/existing_card') do
            subject.v_w_user_lgn.must_equal email
          end
        end

        it 'returns payture card_id' do
          VCR.use_cassette('activate/existing_user/existing_card') do
            subject.card_id.must_equal card_id
          end
        end
      end
    end

    describe '.pay' do
      let(:email) { 'rom2@dom.com' }
      let(:card_number) { 4111111211111112 }
      let(:order_id) { '123asdf123' }
      let(:card_id) { "2e4b31b5-d4db-4cd0-90d8-bdef46cee299" }
      let(:options) {
        {
          v_w_user_lgn: email,
          v_w_user_psw: 123,
          card_id: card_id,
          order_id: order_id,
          amount: '1000',
          ip: '123.123.122.111'
        }
      }
      subject { client.pay options }

      describe 'with existing card not activated' do
        let(:email) { 'rom2@dom.com' }

        it "returns success status" do
          VCR.use_cassette('pay/existing_user/inactive_card') do
            subject.success.must_equal "False"
          end
        end
        it 'returns user login' do
          VCR.use_cassette('pay/existing_user/inactive_card') do
            subject.v_w_user_lgn.must_equal email
          end
        end
        it 'returns empty error code' do
          VCR.use_cassette('pay/existing_user/inactive_card') do
            subject.err_code.must_equal 'WRONG_CARD'
          end
        end
        it 'returns payture card_id' do
          VCR.use_cassette('pay/existing_user/inactive_card') do
            subject.order_id.must_equal order_id
          end
        end
      end

      describe 'with existing activated card' do
        let(:email) { 'fucker1@dom.com' }
        let(:card_id) { "e43544ba-cf4f-4702-85ef-313df89577eb" }
        let(:order_id) { '123asdf123FFFdf' }

        it "returns success status" do
          VCR.use_cassette('pay/existing_user/active_card') do
            subject.success.must_equal "True"
          end
        end
        it 'returns user login' do
          VCR.use_cassette('pay/existing_user/active_card') do
            subject.v_w_user_lgn.must_equal email
          end
        end
        it 'returns empty error code' do
          VCR.use_cassette('pay/existing_user/active_card') do
            subject.err_code.must_be_nil
          end
        end
        it 'returns ORDER_id' do
          VCR.use_cassette('pay/existing_user/active_card') do
            subject.order_id.must_equal order_id
          end
        end
      end
    end

    describe '.get_list' do
      let(:email) { 'fucker@dom.com' }
      let(:options) {
        {
          v_w_user_lgn: email,
          v_w_user_psw: 123,
        }
      }
      subject { client.get_list options }

      it "returns success status" do
        VCR.use_cassette('get_list/existing_user') do
          subject.success.must_equal "True"
        end
      end
    end
  end
end
