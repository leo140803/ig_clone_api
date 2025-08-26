class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :body, null: false
      t.references :parent, foreign_key: { to_table: :comments }, null: true
      t.timestamps
    end
  end
end
