# Rubogram

[![Build Status](https://travis-ci.org/4ndv/rubogram.svg?branch=master)](https://travis-ci.org/4ndv/rubogram)
[![Coverage Status](https://coveralls.io/repos/github/4ndv/rubogram/badge.svg?branch=master)](https://coveralls.io/github/4ndv/rubogram?branch=master)

Rubogram is a small Faraday-based library to communicate with Telegram Bot API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubogram'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubogram

## Usage

At first, require rubogram in your application like this:

```ruby
require 'rubogram'
```

Create client with your token (you can obtain one [here](https://telegram.me/BotFather)):

```ruby
client = Rubogram::Client.new 'TOKENHERE'
```

And then make your requests like this:

```ruby
resp = client.send_message chat_id: '123', text: 'hello, machine world!'
```

So, as you can see `sendMessage` became `send_message` because of ruby guidelines(tm). But you can also use it like `client.sendMessage`, just like in the telegram docs.

Also you can use `call` method:

```ruby
resp = client.call 'sendMessage', chat_id: '123', text: 'Hello!'
```

You can see parsed response of all requests like this. Resp contains full Faraday response:

```ruby
resp.body
```

Note that in case of errors, exception will be raised, so don't forget to handle it

## Options

Rubogram Client has some options you can set, here's full list:

```ruby
client = Rubogram::Client.new 'TOKENHERE', adapter: Faraday.default_adapter, logging: true, raise_errors: true
```

Where:

`adapter` - faraday adapter, look into faraday docs for more of them

`logging` - true/false, enables/disables logging

`raise_errors` - true/false, enables/disables error raising. If you disable this, you can check successfullness of request by verifying `ok` field in the parsed body

## TODO

* Write specs
* Write examples

## Development

After checking out the repo, run `bin/setup` to install dependencies.
To run tests you must specify two environment variables: `TOKEN` with your bot token and `CHATID` with YOUR id.
Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/4ndv/rubogram. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

