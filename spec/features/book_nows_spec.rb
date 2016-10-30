require 'rails_helper'

RSpec.feature "BookNows", type: :feature do
  describe 'Book now button' do
    scenario 'has a book now button that goes to new ticket'
    scenario 'has a book now button inside .ticket-list'
  end
end
