class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.integer :radius, null: false
      t.string :title, limit: 50, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :topic, index: true, foreign_key: true
      t.timestamps
    end
  end
end
