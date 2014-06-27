require 'test_helper'

# A User manages her virtual tickets.
class UserManagesHerTicketsTestTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  Warden.test_mode!

  setup do
    @user = User.create!(email: 'a@b.c', password: '12345678')
    login_as @user
  end

  test 'expired tickets are marked as expired' do
    @user.virtual_tickets.create!(created_at: 1.day.ago)
    visit '/'
    assert page.has_content?('scaduto') || page.has_content?('Scaduto')
  end

  test 'for non expired tickets, their expiration time is displayed' do
    ticket = @user.virtual_tickets.create!
    visit '/'
    assert page.has_content?(ticket.created_at.strftime('%H:%M'))
  end

  test 'requesting a new ticket generates a new ticket' do
    visit '/'
    count_before = VirtualTicket.count
    click_button 'Richiedi'
    @user.reload

    assert page.has_content?('Ecco il tuo ticket')
    assert_equal VirtualTicket.count, count_before + 1
    assert page.has_css?('img')
    assert_equal @user.virtual_tickets.last, VirtualTicket.last
  end
end
