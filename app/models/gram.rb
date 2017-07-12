class Gram < ApplicationRecord
  
# next line added 11 jul 17 for gram validations (lesson 9)
  validates :message, presence: true      # validates messages aren't blank
  
# next line added 11 jul 17 for connecting a gram with a user (lesson 10)
  belongs_to :user
  
end
