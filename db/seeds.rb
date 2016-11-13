# Delete old data.
FeaturedProperty.delete_all
PropertyContainer.delete_all

# Create PropertyContainer that have many featured_properties.
30.times do
  PropertyContainer.create!(name: Faker::Name.name)
end

PropertyContainer.all.each do |container|
  3.times do |i|
    container.featured_properties.create!(
      :start_at     => Date.yesterday,
      :end_at       => Date.tomorrow,
      :notes        => Faker::Hacker.say_something_smart,
      :published_at => i == 0 ? Time.zone.now : nil
    )
  end
end
