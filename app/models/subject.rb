class Subject < ApplicationRecord

	acts_as_list
  has_many :pages

  scope :visible, -> {where(:visible => true)}
  scope :invisible, -> {where(:visible => false)}
  scope :sorted, lambda {order("position ASC")}
  scope :newest_first, lambda{order("created_at DESC")}
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
end
