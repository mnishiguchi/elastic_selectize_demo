# == Schema Information
#
# Table name: weather_stations
#
#  id         :integer          not null, primary key
#  station_id :string
#  latitude   :float
#  longitude  :float
#  elevation  :float
#  state      :string
#  name       :string
#  gsn_flag   :string
#  hcn_flag   :string
#  wmo_id     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WeatherStation < ApplicationRecord
  belongs_to :weather_reading
end
