Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: 'virtual_tickets#index'

    get 'new_virtual_ticket',
      to: 'virtual_tickets#new',
      as: 'new_virtual_ticket'

    get 'virtual_tickets/:id',
      to: 'virtual_tickets#show',
      as: 'virtual_ticket'
  end
end
