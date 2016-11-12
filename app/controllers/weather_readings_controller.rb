class WeatherReadingsController < ApplicationController

  # GET /weather_readings
  def index
    search = WeatherReadingsSearch.new(search_params).search

    @weather_readings = search[:results]
    @active_filters   = search[:active_filters]
  end

  # GET /weather_readings/autocomplete.json
  def autocomplete
    render json: WeatherReadingsAutocomplete.new(search_params).json
  end

  private def search_params
    # TODO: make a whitelist.
    params.permit!
  end
end
