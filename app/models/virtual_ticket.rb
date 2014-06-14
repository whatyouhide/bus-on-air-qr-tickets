require 'securerandom'

class VirtualTicket < ActiveRecord::Base
  belongs_to :user

  VALID_FOR = 90.minutes

  before_create :generate_code

  validate :code, presence: true, uniqueness: true

  has_attached_file :qr_code

  # A ticket is expired if `VALID_FOR` time is passed since its creation.
  def expired?
    Time.now > created_at + VALID_FOR
  end

  private

  # Generate a 40 characters base64 (but url-safe, which is [a-zA-Z0-9_\-]).
  # Keep generating it in case a duplicate is generated.
  # Checking for the record's validity is enough since the presence *and*
  # uniqueness of the `code` attribute.
  def generate_code
    loop do
      self.code = SecureRandom.urlsafe_base64(40)
      break if self.valid?
    end
  end
end
