class CreateIdeas < ActiveRecord::Migration[7.2]
  def change
    create_table :ideas do |t|
      t.references :category, null: false, foreign_key: true
      t.string :idea_kbn, null: false
      t.string :title, null: false
      t.text :body
      t.string :rank, default: "0"
      t.integer :sort
      t.string :status, default: "0"
      t.timestamps
    end
  end
end
