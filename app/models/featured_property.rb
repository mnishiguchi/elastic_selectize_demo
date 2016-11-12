# == Schema Information
#
# Table name: featured_properties
#
#  id                    :integer          not null, primary key
#  end_date              :datetime
#  start_time            :datetime
#  notes                 :string
#  published_at          :datetime
#  property_container_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class FeaturedProperty < ApplicationRecord

  searchkick

  include Publishable

  belongs_to :property_container

  after_commit :reindex_property_container

  # https://github.com/ankane/searchkick#associations
  def reindex_property_container
    property_container.reindex # or reindex_async
  end

  # Allows us to control what data is indexed for searching.
  # https://github.com/ankane/searchkick#indexing
  # NOTE: We need to reindex after making changes to the search attributes.
  def search_data
    merge = {
      property_container_id:   property_container_id,
      property_container_name: property_container.name,
    }
    attributes.merge(merge)
  end
end
