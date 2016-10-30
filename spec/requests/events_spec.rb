require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    it 'receive search param' do
      a = Event.create!(starts_at: 2.days.ago, ends_at: 1.days.ago, venue: Venue.new, category: Category.new, extended_html_description: 'abcd', name: 'Dam Vinh Hung')
      b = Event.create!(starts_at: 2.days.ago, ends_at: 1.days.from_now, venue: Venue.new, category: Category.new, extended_html_description: 'abcd', name: 'Scorpion in Vietnam')

      get root_path(search: 'Scorpion')
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Scorpion in Vietnam'
      expect(response.body).not_to include 'Dam Vinh Hung'
    end
  end

  describe 'GET /events/:id' do
    it 'receive the detail of an event' do
      a = Event.create!(starts_at: 2.days.ago, ends_at: 1.days.ago, venue: Venue.new, category: Category.new, extended_html_description: 'abcd', name: 'Dam Vinh Hung')

      get event_path(a.id)
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Dam Vinh Hung'
    end

    it 'has a book now button' do
      event = create(:event)
      get event_path(event)
      expect(response.body).to include "<a href=\"/events/#{event.id}/tickets/new\">"
    end
  end
end
