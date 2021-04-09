class AddGenderToUsers < ActiveRecord::Migration[6.1]
  def change
    create_enum :user_gender, %w[female male other]

    add_column :users, :gender, :user_gender, null: false, default: 'other'
  end
end
