class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.string :image_url

      t.timestamps
    end
  end
end
