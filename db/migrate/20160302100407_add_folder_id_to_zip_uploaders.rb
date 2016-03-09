class AddFolderIdToZipUploaders < ActiveRecord::Migration
  def change
    add_column :zip_uploaders, :folder_id, :integer
    add_column :users, :folder_id, :integer

  end
end
