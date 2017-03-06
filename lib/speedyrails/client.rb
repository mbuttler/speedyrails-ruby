# frozen_string_literal: true

require 'faraday'

module Speedyrails
  class Client
    SPEEDYRAILS_URI = 'https://api.speedyrails.com'.freeze

    attr_reader :resources

    def initialize(options = {})
      @api_token = options[:api_token]
      @resources ||= {}
    end

    def connection
      @conn ||= Faraday.new SPEEDYRAILS_URI do |f|
        f.adapter Faraday.default_adapter
        f.headers = {'Content-Type' => 'application/json'}
        f.authorization :Bearer, @api_token
      end
    end

    def method_missing(name, *args, &block)
      if Speedyrails.resources.keys.include?(name)
        @resources[name] ||= Speedyrails.resources[name].new(connection: connection)
        @resources[name]
      else
        super
      end
    end
  end
end
