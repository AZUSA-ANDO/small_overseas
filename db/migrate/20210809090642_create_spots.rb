class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.integer :user_id, null: false
      t.integer :overseas_area_id
      t.string :spot_image_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.text :introduction, null: false
      t.integer :japan_area, null: false, default: 0

      t.timestamps
    end
  end
end
