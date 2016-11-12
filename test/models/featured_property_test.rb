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

require 'test_helper'

class FeaturedPropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
