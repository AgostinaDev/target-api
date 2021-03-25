class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :description, limit: 50, null: false

      t.timestamps
    end
  end
end
