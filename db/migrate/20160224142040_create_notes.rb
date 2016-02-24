class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :message
      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end
end
