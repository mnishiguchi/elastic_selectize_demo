# Delete old data.
FeaturedProperty.delete_all
PropertyContainer.delete_all

# Create PropertyContainer that have many featured_properties.
3.times do
  PropertyContainer.create!(name: Faker::Name.name)
end

PropertyContainer.all.each do |container|
  30.times do
    container.featured_properties.create!(
      :start_time   => Date.yesterday,
      :end_date     => Date.tomorrow,
      :notes        => Faker::Hacker.say_something_smart,
      :published_at => Time.zone.now
    )
  end
end