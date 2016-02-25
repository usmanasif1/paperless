class CreateZipUploaders < ActiveRecord::Migration
  def change
    create_table :zip_uploaders do |t|
      t.string :zip
      t.integer :order_id

      t.timestamps
    end
  end
end
