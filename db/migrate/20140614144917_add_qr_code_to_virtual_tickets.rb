class AddQrCodeToVirtualTickets < ActiveRecord::Migration
  def change
    add_attachment :virtual_tickets, :qr_code
  end
end
