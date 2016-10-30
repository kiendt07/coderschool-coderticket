require 'rails_helper'

RSpec.describe 'events', type: :routing do
  it 'routes /upcoming to events#index' do
    expect(get: '/upcoming').to route_to(controller: 'events', action: 'index')
  end

  it 'routes /event/:id to events#show' do
    expect(get: '/events/3').to route_to(controller: 'events', action: 'show', id: '3')
  end
end
