FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    venue { Venue.new }
    category { Category.new }
    extended_html_description { Faker::Hipster.sentence }
    starts_at { 5.days.ago }
    ends_at { 5.days.from_now }
  end
end
