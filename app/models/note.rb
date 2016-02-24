class Note < ActiveRecord::Base
  attr_accessible :message, :order_id, :user_id

  belongs_to :order
  belongs_to :user

end
