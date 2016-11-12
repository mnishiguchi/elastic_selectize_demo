class FeaturedPropertiesController < ApplicationController

  # GET /featured_properties
  def index
    search = FeaturedPropertySearch.new(search_params).search

    @featured_properties = search[:results]
    @active_filters      = search[:active_filters]
  end

  # GET /featured_properties/autocomplete.json
  def autocomplete
    render json: FeaturedPropertyAutocomplete.new(search_params).json
  end

  private def search_params
    # TODO: make a whitelist.
    params.permit!
  end
end
