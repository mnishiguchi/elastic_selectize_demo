# == Schema Information
#
# Table name: weather_readings
#
#  id               :integer          not null, primary key
#  station          :string
#  reading_date     :date
#  reading_type     :string
#  reading_value    :integer
#  measurement_flag :string
#  quality_flag     :string
#  source_flag      :string
#  observation_time :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class WeatherReadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
