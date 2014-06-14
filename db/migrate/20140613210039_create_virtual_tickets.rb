class CreateVirtualTickets < ActiveRecord::Migration
  def change
    create_table :virtual_tickets do |t|
      t.string :code
      t.references :user
      t.timestamps
    end
  end
end
