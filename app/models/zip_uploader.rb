class ZipUploader < ActiveRecord::Base
  attr_accessible :order_id, :zip,:folder_id

  belongs_to :folder
  belongs_to :order

  mount_uploader :zip, ZipFileUploader
end
