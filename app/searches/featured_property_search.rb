class FeaturedPropertySearch
  attr_reader :search_params, :query

  def search_model
    FeaturedProperty
  end

  # Returns an Searchkick::Results object which responds like an array.
  def initialize(search_params)
    @search_params = search_params
    @query         = query
  end

  def query
    search_params[:q].presence || "*"
  end

  # A wrapper of Searchkick's search method. We configure common behavior of
  # all the searches here.
  # arg0: a query string
  # arg1: an search_params hash
  def search
    # Invoke Searchkick's search method with our search constraints.
    @results ||= search_model.search(query, search_constraints)

    # Wrap the information as a hash and pass it to PropertiesController.
    {
      results:        @results,
      active_filters: active_filters
    }
  end

  private def search_constraints
    {
      match:        :word_start,
      misspellings: { below: 5 },
      limit: 30,
      where: where,
      order: order,
      page:  search_params[:page],
      per_page: 20
    }
  end

  # We specify the where clause for the search if needed.
  private def where
    where = {}


    ap where
    return where
  end

  private def order
    return {} unless search_params[:sort_attribute].present?

    order = search_params[:sort_order].presence || :asc
    { search_params[:sort_attribute] => order }
  end

  # Arguments can be either strings or integers.
  private def date_to_time_object(year, month, day)
    [year, month, day].join("-").to_time
  end

  # This can be used for displaying active filters in UI.
  private def active_filters
    slice = [
      "q",
      "sort_attribute",
      "sort_order",
    ]
    search_params.to_h.slice(*slice).reject { |_, v| v.blank? }
  end
end
