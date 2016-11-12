class CreateFeaturedProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :featured_properties do |t|
      t.datetime :end_date
      t.datetime :start_time
      t.string :notes
      t.datetime :published_at
      t.references :property_container, foreign_key: true

      t.timestamps
    end
  end
end
