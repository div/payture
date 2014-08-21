# Payture

This gems wraps e-walet api of payture.com credit card processing

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payture_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payture_ruby

## Configuration

In an initializer:

```ruby
Payture.configure do |config|
  config.host_type = 'sandbox' # or 'secure'
  config.key = 'WVMerchant' # your user access key
  config.password = 'Secret' # your user access pass
end
```

Or you can just pass options to initializer

```ruby
  Payture::Cleient.new host_type: :secure
```

## Usage

Instanciate api client or call methods on Payture module directly

```ruby
  client = Payture::Cleient.new host_type: :secure
  client.register v_w_user_lgn: '123@ya.ru', v_w_user_psw: 123, phone_number: 79156783333

  Payture.get_list v_w_user_lgn: '123@ya.ru', v_w_user_psw: 123
```

## Contributing

1. Fork it ( https://github.com/div/payture/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
