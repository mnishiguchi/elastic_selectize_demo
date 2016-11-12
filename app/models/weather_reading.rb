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

class WeatherReading < ApplicationRecord

  searchkick

  has_one :weather_station, foreign_key: 'station_id', primary_key: 'station'

  # Allows us to control what data is indexed for searching.
  # https://github.com/ankane/searchkick#indexing
  # NOTE: We need to reindex after making changes to the search attributes.
  def search_data
    merge = {
      station_name: weather_station.name,

      # http://apidock.com/rails/String/to_time
      reading_date: reading_date.to_time,
    }
    attributes.merge(merge)
  end
end
