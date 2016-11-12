class WeatherReadingsAutocomplete < WeatherReadingsSearch

  def json
    search_model.search(query, search_constraints).map do |result|
      [
        result.reading_type,
        result.station_name
      ]
    end.flatten.uniq.to_json
  end

  private def search_constraints
    {
      match:        :word_start,
      misspellings: { below: 5 },
      limit: 10,
      load:  false,
      where: where,
      order: order,
    }
  end
end
