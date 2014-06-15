class VirtualTicketsController < ApplicationController
  # GET /
  def index
  end

  # GET /new_virtual_ticket
  def new
    @ticket = current_user.virtual_tickets.create
    redirect_to virtual_ticket_path(@ticket)
  end

  # GET /virtual_tickets/1
  def show
    @ticket = VirtualTicket.find(params[:id])
  end
end
