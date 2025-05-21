class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :body
      t.string :status, default: "0"
      t.timestamps
    end

    add_index :categories, [ :user_id, :title ]
  end
end
