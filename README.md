# unione-ruby
UniOne (unione.io) integration gem for Ruby

[Examples of usage](https://github.com/unione-repo/unione-ruby/tree/master/examples)

## Install

    gem install unione-ruby

## Working with API responses
This library using [faraday](https://github.com/lostisland/faraday) gem for making HTTP queries along with [mashify middleware](https://github.com/hashie/hashie#mash) for post-processing response body. So, you can use extended syntax for accessing response fields.

Example of work with responses:

~~~ruby
require 'unione-ruby'
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.get_dns_records("example.com")
puts response.status
puts response.body.to_h
puts response.headers
# Access fields as hash or as methods
puts response.body['status']
puts response.body.status
~~~

By default authentication produced through X-API-KEY header. For passing API key in params use:

```
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'], api_key_in_params: true)
```

## Handling API errors
Library using [`raise-error' middleware](https://lostisland.github.io/faraday/middleware/raise-error) for handling error responses.

Example of work with errors:

~~~ruby
require 'unione-ruby'
begin
  unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
  response = unione.get_dns_records("example.com")
  puts response.status
  puts response.body.to_h
  puts response.headers
rescue Faraday::Error => e
  # Note that exception response has internal format which is a little bit different and body field is not post-processed
  puts e.response[:status]
  puts e.response[:body]
  puts e.response[:headers]
end
~~~
