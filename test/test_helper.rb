# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'speedyrails'

require 'minitest/autorun'
require 'webmock/minitest'

def resource_uri(resource, **args)
  uri = URI.parse("https://api.speedyrails.com/v0/#{resource}")
  return uri.to_s if args.keys.empty?

  uri.path += "/#{args[:id]}" if args.keys.include?(:id)
  args.reject! { |k| k == :id }

  uri.query = URI.encode_www_form(args.to_a)
  uri.to_s
end
