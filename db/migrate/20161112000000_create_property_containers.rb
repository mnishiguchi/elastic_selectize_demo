class CreatePropertyContainers < ActiveRecord::Migration[5.0]
  def change
    create_table :property_containers do |t|
      t.string :name

      t.timestamps
    end
  end
end
