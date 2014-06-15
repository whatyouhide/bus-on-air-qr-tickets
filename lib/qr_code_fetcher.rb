require 'active_support'
require 'uri'
require 'open-uri'

module QrCodeFetcher
  BASE = 'http://api.qrserver.com/v1/create-qr-code/'

  class QrCodeUnavailable < StandardError; end

  # Build the url where to GET the qr code.
  def self.fetch_url(data)
    data_with_better_keys = {
      data: data[:code]
    }

    URI.join(BASE, "?#{data_with_better_keys.to_param}").to_s
  end

  def self.qr_code(code)
    open(fetch_url(code: code))
  rescue OpenURI::HTTPError => e
    raise QrCodeUnavailable.new(e.message)
  end
end
