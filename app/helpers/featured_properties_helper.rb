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

  # def reading_type_text(filter_hash)
  #   if filter_hash[:reading_type].present?
  #     "Reading type: #{filter_hash[:reading_type]}"
  #   end
  # end
  #
  # def reading_value_text(filter_hash)
  #   min, max = filter_hash[:reading_value_min], filter_hash[:reading_value_max]
  #   if min.present? && max.present?
  #     "Reading value: #{min} to #{max}"
  #   elsif min.present?
  #     "Reading value: Min #{min}"
  #   elsif max.present?
  #     "Reading value: Max #{max}"
  #   end
  # end
  #
  # # TODO
  # def reading_date_text(filter_hash)
  #   # if filter_hash[:reading_type].present?
  #   #   "Reading type: #{filter_hash[:reading_type]}"
  #   # end
  # end


  # ---
  # Filtering
  # ---


  def property_container_id_select_tag(params)
    options = []
    select_tag(
      "property_container_id",
      options_for_select(options, params[:property_container_id]),
      include_blank: true,
      id: "select-featured-property-new"
    )
  end

  def publish_status_select_tag(params)
    options = %w(published unpublished).map(&:titleize)
    select_tag(
      "publish_status",
      options_for_select(options, params[:publish_status]),
      include_blank: true
    )
  end

  def active_status_select_tag(params)
    options = %w(active archived not_yet_active).map(&:titleize)
    select_tag(
      "active_status",
      options_for_select(options, params[:active_status]),
      include_blank: true
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
