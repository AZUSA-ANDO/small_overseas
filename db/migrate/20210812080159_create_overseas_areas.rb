class CreateOverseasAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :overseas_areas do |t|
      t.string :name, null:false
      t.integer :spot_id

      t.timestamps
    end
  end
end
