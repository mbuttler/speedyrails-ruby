# frozen_string_literal: true

require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @token = 'd468bca5f99f35622e08870c772b4e65'
    @client = Speedyrails::Client.new(api_token: @token)
  end

  def test_connection_headers
    headers = @client.connection.headers

    assert_equal 'application/json', headers['Content-Type']
    assert_equal "Bearer #{@token}", headers['Authorization']
  end

  def test_method_missing_with_resource
    name, klass = Speedyrails.resources.to_a.sample
    resource = @client.send(name)

    assert_instance_of klass, resource
  end

  def test_method_missing_with_missing_resource
    assert_raises NoMethodError do
      @client.not_a_resource_name
    end
  end
end
