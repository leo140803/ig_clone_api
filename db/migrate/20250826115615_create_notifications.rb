class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true # recipient
      t.references :actor, null: false, foreign_key: { to_table: :users }
      t.string :action, null: false # 'liked', 'commented', 'followed'
      t.references :notifiable, polymorphic: true, null: false
      t.datetime :read_at
      t.timestamps
    end
    add_index :notifications, :created_at
  end
end
