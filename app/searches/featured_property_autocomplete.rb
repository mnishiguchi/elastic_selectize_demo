class FeaturedPropertyAutocomplete < FeaturedPropertySearch

  def json
    results = search_model.search(query, search_constraints)

    puts
    print "==>FeaturedPropertyAutocomplete: "
    ap "total_count #{results.total_count}"
    puts
    print "  active_filters: "
    ap active_filters
    puts

    # Selectize.js requires us to return a json object for the suggestion list.
    {
      results: results
    }
  end

  private def search_constraints
    {
      match:        :word_start,
      misspellings: { below: 5 },
      load:  false,
      where: where,
    }
  end
end
