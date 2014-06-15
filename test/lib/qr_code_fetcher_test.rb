require 'test_helper'
require 'qr_code_fetcher'

class QrCodeFetcherTest < ActiveSupport::TestCase
  test '::fetch_url' do
    assert_equal QrCodeFetcher.fetch_url(code: 'foo'),
      QrCodeFetcher::BASE + '?data=foo'
  end
end
