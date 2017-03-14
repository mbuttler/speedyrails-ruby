# Speedyrails

Official gem for the Speedyrails API (v0)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'speedyrails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install speedyrails

## Usage

### Client

Create an instance of the client to interact with the API

```ruby
require 'speedyrails'

token = 'f805b608af8f915b74b0a2e8d14a'
client = Speedyrails.new(api_token: token)
```

### Certificates
Get all certificates for an organization
```ruby
client.certificates.all
# => [#<Speedyrails::Certificate @id='id'>, #<Speedyrails::Certificate @id='id'>]
```

Get all certificates matching a specific label
```ruby
client.certificates.all(label: 'label')
# => [#<Speedyrails::Certificate @id='id'>]
```

Get a single certificate by `id`
```ruby
client.certificates.find(id: 'id')
# => #<Speedyrails::Certificate @id='id'>
```

Create a new certificate
```ruby
certificate = Speedyrails::Certificate.new(
  label: 'example',
  domains: ['example.com', 'www.example.com']
)
client.certificates.create(certificate)
# => #<Speedyrails::Certificate @id='id'>
```
