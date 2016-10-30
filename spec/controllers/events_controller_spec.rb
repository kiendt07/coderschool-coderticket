require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #show' do
    # Using let
    let(:event){ create(:event) }

    it 'assign the requested event to @event' do
      get :show, id: event
      expect(assigns(:event)).to eq(event)
    end
    
    it 'render the :show template' do
      get :show, id: event
      expect(response).to render_template('show')
    end
  end
end
