# frozen_string_literal: true

require 'test_helper'

class CertificateTest < Minitest::Test
  def setup
    @token = 'd468bca5f99f35622e08870c772b4e65'
    @client = Speedyrails::Client.new(api_token: @token)

    @certificate = {
      id: '507f1f77bcf86cd799439011',
      label: 'example',
      domains: ['example.com', 'www.example.com'],
      certificate: 'CERTIFICATE',
      chain: 'CERTIFICATE_CHAIN',
      private_key: 'RSA_PRIVATE_KEY',
      expires_at: '2017-04-25T03:35:00.000+00:00',
      created_at: '2017-01-25T03:35:00.000+00:00'
    }
  end

  def test_certificate_resource_name
    obj = @client.certificates
    assert_instance_of Speedyrails::CertificateResource, obj
  end

  def test_certificate_mapping_writable_properties
    create_properties = Speedyrails::CertificateMapping
                        .kartograph.properties.filter_by_scope(:create)

    assert_equal 2, create_properties.count
    assert_equal [:domains, :label], create_properties.map(&:name).sort
  end

  def test_certificate_resource_all
    stub_request(:get, certificate_uri).to_return(
      status: 200,
      body: {certificates: [@certificate]}.to_json
    )

    certificates = @client.certificates.all
    assert_same_certificates @certificate, certificates[0]
  end

  def test_certificate_resource_all_with_label
    label = 'example'
    stub_request(:get, certificate_uri(label: label)).to_return(
      status: 200,
      body: {certificates: [@certificate]}.to_json
    )

    certificates = @client.certificates.all(label: label)
    assert_same_certificates @certificate, certificates[0]
  end

  def test_certificate_resource_find
    id = '507f1f77bcf86cd799439011'
    stub_request(:get, certificate_uri(id: id)).to_return(
      status: 200,
      body: {certificate: @certificate}.to_json
    )

    certificate = @client.certificates.find(id: id)

    assert_equal id, certificate.id
    assert_same_certificates @certificate, certificate
  end

  def test_certificate_resource_find_error
    id = 'bad_id'
    stub_request(:get, certificate_uri(id: id)).to_return(
      status: 404,
      body: {
        id: 'not_found',
        message: 'The resource you requested could not be found'
      }.to_json
    )

    assert_raises Speedyrails::Error do
      @client.certificates.find(id: id)
    end
  end

  def test_certificate_resource_create
    stub_request(:post, certificate_uri).to_return(
      status: 201,
      body: {certificate: @certificate}.to_json
    )

    certificate = Speedyrails::Certificate.new(
      label: 'example',
      domains: ['example.com', 'www.example.com']
    )

    certificate = @client.certificates.create(certificate)
    assert_same_certificates @certificate, certificate
  end

  def test_certificate_resource_create_error
    stub_request(:post, certificate_uri).to_return(
      status: 422,
      body: {
        id: 'unprocessable',
        message: 'Domain `example.com` is already taken'
      }.to_json
    )

    certificate = Speedyrails::Certificate.new(
      label: 'example',
      domains: ['example.com', 'www.example.com'],
      fake: 'fweifnwepof'
    )

    assert_raises Speedyrails::Error do
      @client.certificates.create(certificate)
    end
  end

  private

  def certificate_uri(**args)
    resource_uri 'certificates', **args
  end

  def assert_same_certificates(hash, obj)
    assert_equal hash[:id], obj.id
    assert_equal hash[:label], obj.label
    assert_equal hash[:domains], obj.domains
    assert_equal hash[:certificate], obj.certificate
    assert_equal hash[:chain], obj.chain
    assert_equal hash[:private_key], obj.private_key
    assert_equal hash[:expires_at], obj.expires_at
    assert_equal hash[:created_at], obj.created_at
  end
end
