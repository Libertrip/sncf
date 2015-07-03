# SNCF Open Data API Ruby wrapper

[![Gem Version](https://badge.fury.io/rb/sncf.svg)](http://badge.fury.io/rb/sncf)

Ruby gem to use easily the SNCF Open Data API with Ruby.

Current SNCF Open Data API version: `1.0`

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

## Fetch train stations

```ruby
require 'sncf'

# Create your Sncf::ApiClient with your API_KEY
client = Sncf::ApiClient.new('MY_API_KEY')

client.api_key
=> 'MY_API_KEY'

# Will returns a parsed model
response = client.fetch_stations('Lille Europe')
=> [#<Sncf::Models::Station:0x007fee0cf051c0
  @administrative_regions=
   [#<Sncf::Models::AdministrativeRegion:0x007fee0cf05490
     @coord={"lat"=>"50.630508", "lon"=>"3.070641"},
     @id="admin:58404extern",
     @insee="59350",
     @label="Lille (59000-59800)",
     @level=8,
     @name="Lille",
     @zip_code="59000;59800">],
  @coord={"lat"=>"50.638861", "lon"=>"3.075774"},
  @id="stop_area:OCE:SA:87223263",
  @label="gare de Lille Europe (Lille)",
  @name="gare de Lille Europe",
  @quality=80,
  @timezone="Europe/Paris">]

```

## Fetch journeys by stations name

```ruby
require 'sncf'

# Create your Sncf::ApiClient with your API_KEY
client = Sncf::ApiClient.new('MY_API_KEY')

# Without options
response_without_options = client.fetch_journeys_by_stations('Paris Nord', 'Lille Europe', Time.now)
=> #<Sncf::ApiResponse:0x007f8b0592abe8
  @body        = #<HTTP::Response::Body:3fc582c9818c @streaming=true>,
  @content     = { ... }, # Here is the api response
  @pagination  = nil,
  @response    = #<HTTP::Response/1.1 200 OK ...>,
  @start_page  = 0>

# With options
response_with_options = client.fetch_journeys_by_stations('Paris Nord', 'Lille Europe', Time.now, { datetime_represents: 'arrival' })
=> #<Sncf::ApiResponse:0x007f8b0592abe8
  @body        = #<HTTP::Response::Body:3fc582c9818c @streaming=true>,
  @content     = { ... }, # Here is the api response
  @pagination  = nil,
  @response    = #<HTTP::Response/1.1 200 OK ...>,
  @start_page  = 0>

```

Available options are available here: [https://data.sncf.com/api/documentation#title.1.6.4.1](https://data.sncf.com/api/documentation#title.1.6.4.1)

## Custom API fetch

```ruby
require 'sncf'

# Create your Sncf::ApiClient with your API_KEY
client = Sncf::ApiClient.new('MY_API_KEY')

client.api_key
=> 'MY_API_KEY'

response = client.fetch('coverage')
=> #<Sncf::ApiResponse:0x007f8b0592abe8
  @body        = #<HTTP::Response::Body:3fc582c9818c @streaming=true>,
  @content     = { ... }, # Here is the api response
  @pagination  = nil,
  @response    = #<HTTP::Response/1.1 200 OK ...>,
  @start_page  = 0>

```

Available `fetch` parameters and API actions are here [https://data.sncf.com/api/documentation#title.1.2.3](https://data.sncf.com/api/documentation#title.1.2.3)

## Contributing

1. Fork it ( https://github.com/Libertrip/sncf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
