require 'active_support'
require 'uri'
require 'open-uri'

# Fetch QR codes over the internet.
module QrCodeFetcher
  BASE = 'http://api.qrserver.com/v1/create-qr-code/'

  class QrCodeUnavailable < StandardError; end

  # Build the url where to GET the qr code.
  def self.fetch_url(data)
    data_with_better_keys = {
      data: data[:code],
      size: '500x500'
    }

    URI.join(BASE, "?#{data_with_better_keys.to_param}").to_s
  end

  def self.qr_code(code)
    open(fetch_url(code: code))
  rescue OpenURI::HTTPError => exception
    raise QrCodeUnavailable, exception.message
  end
end
