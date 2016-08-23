class Description < ActiveRecord::Base
  belongs_to :invoice

  validates :description, presence: true

  # THIS IS WRONG, JUST A TEST!!!!
  # VALIDATIONS
end
