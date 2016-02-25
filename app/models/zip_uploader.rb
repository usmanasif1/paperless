class ZipUploader < ActiveRecord::Base
  attr_accessible :order_id, :zip

  belongs_to :order

  mount_uploader :zip, ZipFileUploader
end
