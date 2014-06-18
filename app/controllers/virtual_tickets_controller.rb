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

  # GET /verify/13jg1vljkblruhvpq98ghrpqeioghqpe9
  def verify
    @ticket = VirtualTicket.find_by_code(params[:code])
  end
end
