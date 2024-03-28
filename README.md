# unione-ruby

UniOne (unione.io) integration gem for Ruby

[Examples of usage](https://github.com/unione-repo/unione-ruby/tree/master/examples)

## Installation

    gem install unione-ruby

## Working with API responses

This library uses [faraday](https://github.com/lostisland/faraday) gem for making HTTP queries along with [mashify middleware](https://github.com/hashie/hashie#mash) for post-processing response body. So, you can use extended syntax for accessing response fields.

Example of work with responses:

~~~ruby
require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

response = unione.get_dns_records("example.com")

puts response.status
puts response.body.to_h
puts response.headers

# Access fields as hash keys or as object attributes:
puts response.body['status']
puts response.body.status
~~~

## Passing API key in parameters

By default authentication sent through X-API-KEY header.

For passing API key in parameters, use:

~~~ruby
unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY'],
  api_key_in_params: true
)
~~~

## Verify webhook callback message

Will raise Unione::Client::InvalidCallbackAuth error unless `auth' field is correct.

~~~ruby
unione.verify_callback_auth!(params)
~~~

## Webhook callback helper

Use it to substitute webhook handler verification and parsing to
directly get list of events.

Will raise Unione::Client::InvalidCallbackAuth error unless `auth' field is correct.

~~~ruby
unione.callback_helper(params) do |events|
  # [
  #   {
  #     'event_name' => 'transactional_email_status',
  #     'event_data' =>
  #      {
  #        'email' => 'recipient.email@example.com',
  #        'status' => 'sent',
  #        'event_time' => '2015-11-30 15:09:42',
  #       ...
  #      }
  #   },
  #   ...
  # ]
end
~~~

## Handling API errors

Library using [`raise-error' middleware](https://lostisland.github.io/faraday/middleware/raise-error) for handling error responses.

Example of work with errors:

~~~ruby
require 'unione-ruby'

begin

  unione = UniOne::Client.new(
    hostname: 'eu1.unione.io',
    lang: 'en',
    api_key: ENV['UNIONE_API_KEY']
  )

  response = unione.get_dns_records("example.com")

  puts response.status
  puts response.body.to_h
  puts response.headers

rescue Faraday::Error => e

  # Note that exception response has internal format which is a little
  # bit different and body field is not post-processed

  puts e.response[:status]
  puts e.response[:body]
  puts e.response[:headers]

end
~~~

## HTTP timeout configuration

Pass `timeout: <seconds>` parameter on creating client, default is 5.

## HTTP logging

Pass `enable_logging: true` parameter on creating client to enable logging, default false.

## Testing

You can run tests through included test task and passing methods for
test and data inside YAML config file:

    rake test DOMAIN APIKEY WEBHOOK_URL FROM_EMAIL ./test/CONFIGFILE.yml
