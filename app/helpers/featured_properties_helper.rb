module FeaturedPropertiesHelper

  def featured_properties_title
    total_count_text(@featured_properties)
  end


  # ---
  # Search meta
  # ---


  def total_count_text(results)
    "#{pluralize(results.try!(:total_count), "record")} found"
  end

  def q_text(filter_hash)
    if filter_hash["q"]&.present?
      filter_hash["q"]
    end
  end

  # def property_type_text(filter_hash)
  #   if filter_hash[:property_type].present?
  #     "type: #{filter_hash[:property_type]}"
  #   end
  # end


  # ---
  # Filtering
  # ---


  def publish_status_select_tag(params)
    options = %w(published unpublished).map(&:titleize)
    select_tag(
      "publish_status",
      options_for_select(options, params[:publish_status]),
      include_blank: true,
      class: "form-control"
    )
  end

  def active_status_select_tag(params)
    options = %w(active archived not_yet_active).map(&:titleize)
    select_tag(
      "active_status",
      options_for_select(options, params[:active_status]),
      include_blank: true,
      class: "form-control"
    )
  end


  # ---
  # Sorting
  # ---


  # def sort_attribute_select_tag(params)
  #   options = {
  #     "station_name"  => "station_name",
  #     "station"       => "station",
  #   }
  #   select_tag(
  #     "sort_attribute",
  #     options_for_select(options, params[:sort_attribute]),
  #     include_blank: false
  #   )
  # end

  def sort_order_select_tag(params)
    options = {
      "Ascending"  => "asc",
      "Descending" => "desc"
    }
    select_tag(
      "sort_order",
      options_for_select(options, params[:sort_order]),
      include_blank: false
    )
  end
end
