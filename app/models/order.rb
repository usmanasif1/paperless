class Order < ActiveRecord::Base
  attr_accessible :from_date, :name, :no_of_sheets, :sheet_type, :to_date,:email, :phone
  attr_accessor :email, :phone
  belongs_to :user
  has_many :notes
  has_many :zip_uploaders

  validates :from_date, presence: true 
  validates :to_date, presence: true 
  validates :name, presence: true, uniqueness: true
  validates :no_of_sheets, presence: true 
  validates :sheet_type, presence: true 
end
