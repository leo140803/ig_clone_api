class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :caption
      t.string :location
      t.timestamps
    end
    add_index :posts, :created_at
  end
end
