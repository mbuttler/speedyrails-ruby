# frozen_string_literal: true

module Speedyrails
  class Error < StandardError
    include Virtus.model

    attribute :id
    attribute :status
    attribute :message

    def message=(msg)
      msg = "#{status} #{msg}" if status
      super msg
    end
  end

  class ErrorMapping
    include Kartograph::DSL

    kartograph do
      mapping Error

      property :id, scopes: [:read]
      property :status, scopes: [:read]
      property :message, scopes: [:read]
    end

    def self.extract_single_and_raise(content, status)
      error = extract_single(append_status(content, status), :read)
      raise error
    end

    def self.append_status(content, status)
      content.gsub(/\}$/, ",\"status\":#{status}}")
    end
  end
end
