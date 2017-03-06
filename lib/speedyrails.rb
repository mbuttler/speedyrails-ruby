# frozen_string_literal: true

require 'kartograph'
require 'resource_kit'
require 'virtus'

require 'speedyrails/version'
require 'speedyrails/client'
require 'speedyrails/error'

require 'speedyrails/certificate'

module Speedyrails
  def self.new(*args)
    Client.new(*args)
  end

  def self.resources
    {certificates: CertificateResource}
  end
end
