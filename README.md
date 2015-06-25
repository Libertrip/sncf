# SNCF Open Data API Ruby wrapper

# This gem in currently in beta, it may contains bugs, do not use in production.

# 1.0.0 release is due to Fri, 03 Jul 2015

[![Gem Version](https://badge.fury.io/rb/sncf.svg)](http://badge.fury.io/rb/sncf)

Ruby gem to use easily the SNCF Open Data API with Ruby.

API Documentation is available [here](https://data.sncf.com/api)

You don't already have an API KEY ? [Register here!](https://data.sncf.com/api/register)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sncf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sncf

## Usage

```ruby
require 'sncf'

# Create your Sncf::ApiClient with your API_KEY
client = Sncf::ApiClient.new('MY_API_KEY')

client.api_key
=> 'MY_API_KEY'

response = req.fetch('coverage')
=> #<Sncf::ApiResponse:0x007f8b0592abe8
  @body        = #<HTTP::Response::Body:3fc582c9818c @streaming=true>,
  @content     = { ... }, # Here is the api response
  @pagination  = nil,
  @response    = #<HTTP::Response/1.1 200 OK ...>,
  @start_page  = 0>

```

Available `fetch` parameters and API actions are here [https://data.sncf.com/api/documentation#title.1.2.3](https://data.sncf.com/api/documentation#title.1.2.3)

## Contributing

1. Fork it ( https://github.com/rdlh/sncf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
