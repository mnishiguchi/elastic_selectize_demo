# == Schema Information
#
# Table name: property_containers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PropertyContainer < ApplicationRecord

  searchkick
  
  has_many :featured_properties
end
