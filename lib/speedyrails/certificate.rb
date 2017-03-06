# frozen_string_literal: true

module Speedyrails
  class Certificate
    include Virtus.model

    attribute :id
    attribute :label
    attribute :domains
    attribute :certificate
    attribute :chain
    attribute :private_key
    attribute :expires_at
    attribute :created_at
  end

  class CertificateMapping
    include Kartograph::DSL

    kartograph do
      mapping Certificate
      root_key singular: 'certificate', plural: 'certificates', scopes: [:read]

      property :id, scopes: [:read]
      property :label, scopes: [:read, :create]
      property :domains, scopes: [:read, :create]
      property :certificate, scopes: [:read]
      property :chain, scopes: [:read]
      property :private_key, scopes: [:read]
      property :expires_at, scopes: [:read]
      property :created_at, scopes: [:read]
    end
  end

  class CertificateResource < ResourceKit::Resource
    resources do
      default_handler do |response|
        next if (200...299).cover?(response.status)
        ErrorMapping.extract_single_and_raise(response.body, response.status)
      end

      action :all, 'GET /v0/certificates' do
        query_keys :label
        handler(200) { |resp| CertificateMapping.extract_collection(resp.body, :read) }
      end

      action :find, 'GET /v0/certificates/:id' do
        handler(200) { |resp| CertificateMapping.extract_single(resp.body, :read) }
      end

      action :create, 'POST /v0/certificates' do
        body { |obj| CertificateMapping.representation_for(:create, obj) }
        handler(201) { |resp, obj| CertificateMapping.extract_into_object(obj, resp.body, :read) }
      end
    end
  end
end
