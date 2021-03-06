class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types
  belongs_to :user

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    Event.where('ends_at > ?', Time.now)
  end

  def published?
    !published_at.nil?
  end

  def self.published
    Event.where.not(published_at: nil)
  end
end
