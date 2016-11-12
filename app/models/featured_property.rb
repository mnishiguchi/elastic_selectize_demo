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
  
  belongs_to :property_container

  # Allows us to control what data is indexed for searching.
  # https://github.com/ankane/searchkick#indexing
  # NOTE: We need to reindex after making changes to the search attributes.
  def search_data
    merge = {

    }
    attributes.merge(merge)
  end
end
