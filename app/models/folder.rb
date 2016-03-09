class Folder < ActiveRecord::Base
  attr_accessible :name, :parent_id, :user_id

  has_many :zip_uploaders
  # validates_uniqueness_of :name, :scope => :parent_id
  validates_presence_of :name


  belongs_to :user

  def is_root?
    self.parent_id.nil? && !new_record?
  end
end
