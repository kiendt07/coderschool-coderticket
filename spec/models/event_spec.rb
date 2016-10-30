require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '.upcoming' do
    it 'return [] if there are no events' do
      expect(Event.upcoming).to eq []
    end
    it 'return [] if there are only past events' do
      Event.create!(starts_at: 2.days.ago, ends_at: 1.days.ago, venue: Venue.new, category: Category.new, extended_html_description: 'abcd')
      expect(Event.upcoming).to eq []
    end
    it 'return [b] if there are a past event a and a future event b' do
      a = Event.create!(starts_at: 2.days.ago, ends_at: 1.days.ago, venue: Venue.new, category: Category.new, extended_html_description: 'abcd', name: 'a')
      b = Event.create!(starts_at: 2.days.ago, ends_at: 1.days.from_now, venue: Venue.new, category: Category.new, extended_html_description: 'abcd', name: 'b')

      expect(Event.upcoming).to eq [b]
    end
  end
end
