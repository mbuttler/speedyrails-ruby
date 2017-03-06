# frozen_string_literal: true

require 'test_helper'

class ErrorTest < Minitest::Test
  def test_error_extract_single_and_raise
    error = {id: 422, message: 'Error test'}

    assert_raises Exception do
      Speedyrails::ErrorMapping.extract_single_and_raise(error.to_json)
    end
  end
end
