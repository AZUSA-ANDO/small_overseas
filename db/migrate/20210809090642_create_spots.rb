class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.integer :user_id, null: false
      t.references :overseas_area, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.text :introduction, null: false
      t.integer :japan_area, null: false, default: 0

      t.timestamps
    end
  end
end
