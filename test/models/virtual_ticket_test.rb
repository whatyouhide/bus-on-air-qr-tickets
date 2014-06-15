require 'test_helper'

class VirtualTicketTest < ActiveSupport::TestCase
  test 'expired?' do
    t = VirtualTicket.create
    assert_not t.expired?

    t.created_at = 5.days.ago
    assert t.expired?
  end

  test 'valid_until' do
    t = VirtualTicket.create
    assert_equal t.valid_until, t.created_at + VirtualTicket::VALID_FOR
  end

  test 'creation callbacks' do
    ticket = VirtualTicket.create
    assert_not_nil ticket.code
    assert_not_nil ticket.qr_code
  end

  test 'code generation before creation' do
    ticket = VirtualTicket.create
    new_ticket = VirtualTicket.create code: ticket.code
    assert_not_equal ticket.code, new_ticket.code
  end
end
