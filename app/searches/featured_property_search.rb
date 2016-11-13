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

  def search
    # Invoke Searchkick's search method with our search constraints.
    @results ||= search_model.search(query, search_constraints)

    puts
    print "==>FeaturedPropertySearch: "
    ap "total_count #{@results.total_count}"
    puts
    print "  active_filters: "
    ap active_filters
    puts

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

    # param => comma-separated multi-item string
    # where => array of strings
    if search_params[:property_container_name].present?
      where[:property_container_name] = search_params[:property_container_name].split(",")
    end

    # param => "Published" or "Unpublished"
    # where => Time or nil
    if search_params[:publish_status].present?
      case search_params[:publish_status]
      when "Published"
        where[:published_at] = { gt: Time.at(0).to_datetime }
      when "Unpublished"
        where[:published_at] = nil
      end
    end

    ap where
    return where
  end

  private def order
    return {} unless search_params[:sort_attribute].present?

    order = search_params[:sort_order].presence || :asc
    { search_params[:sort_attribute] => order }
  end

  # # Arguments can be either strings or integers.
  # private def date_to_time_object(year, month, day)
  #   [year, month, day].join("-").to_time
  # end

  # This can be used for displaying active filters in UI.
  private def active_filters
    @active_filters ||= begin
      slice = [
        "q",
        "property_container_name",
        "sort_attribute",
        "sort_order",
      ]
      search_params.to_h.slice(*slice).reject { |_, v| v.blank? }
    end
  end
end
