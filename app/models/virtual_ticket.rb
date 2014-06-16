require 'securerandom'
require 'qr_code_fetcher'

# A virtual ticket: a ticket which has a unique code and an associated QR code
# (an image).
class VirtualTicket < ActiveRecord::Base
  VALID_FOR = 90.minutes

  belongs_to :user

  before_create :generate_code, :fetch_qr_code

  validate :code, presence: true, uniqueness: true

  has_attached_file :qr_code
  validates_attachment :qr_code, content_type: {
    content_type: %w(image/png image/jpeg)
  }

  # A ticket is expired if `VALID_FOR` time is passed since its creation.
  def expired?
    Time.now > valid_until
  end

  # The time when this ticket will expire.
  def valid_until
    created_at + VALID_FOR
  end

  private

  # Generate a 40 characters base64 (but url-safe, which is [a-zA-Z0-9_\-]).
  # Keep generating it in case a duplicate is generated; checking for the
  # record's validity is enough since the presence *and* # uniqueness of the
  # `code` attribute.
  def generate_code
    loop do
      self.code = SecureRandom.urlsafe_base64(40)
      break if valid?
    end
  end

  # Fetch a QR code over the internet and store it in the `qr_code` attribute.
  def fetch_qr_code
    self.qr_code = QrCodeFetcher.qr_code(code)
  end
end
