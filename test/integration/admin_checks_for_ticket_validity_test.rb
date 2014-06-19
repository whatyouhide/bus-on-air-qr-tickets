require 'test_helper'

# An admin user verifies if a code (which he presumably scanned with a QR code
# reader) is valid, expired or if it doesn't match any ticket in the db.
class AdminChecksForTicketValidityTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  Warden.test_mode!

  setup do
    @admin = User.create!(email: 'a@b.com', password: '12345678', admin: true)
    @valid_ticket = VirtualTicket.create!
    @expired_ticket = VirtualTicket.create!(created_at: 2.days.ago)

    login_as @admin
  end

  test "admin enters a code which matches a valid ticket" do
    visit '/'
    fill_in 'code', with: @valid_ticket.code
    click_button 'Verifica'
    assert page.has_content?('Ticket valido')
  end

  test "admin enters a code which matches an expired ticket" do
    visit '/'
    fill_in 'code', with: @expired_ticket.code
    click_button 'Verifica'
    assert page.has_content?('scaduto')
  end

  test "admin enters a code which matches no tickets" do
    visit '/'
    fill_in 'code', with: 'foo'
    click_button 'Verifica'
    assert page.has_content?('non trovato')
  end
end
