class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :no_of_sheets
      t.string :sheet_type
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
