class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.string :content
      t.integer :trip_id
    end
  end
end
