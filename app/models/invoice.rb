class Invoice < ActiveRecord::Base
  belongs_to :freelancer
  belongs_to :client

  has_many :descriptions

  accepts_nested_attributes_for :client
end
