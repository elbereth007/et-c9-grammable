class Gram < ApplicationRecord
  
# next line added 11 jul 17 for gram validations (lesson 9)
  validates :message, presence: true      # validates messages aren't blank
# next line added 12 jul 17 for image validations (lesson 17)
  validates :picture, presence: true
# next line added 12 jul 17 for comments (lesson 18)
  has_many :comments
  
# next line added 11 jul 17 for connecting a gram with a user (lesson 10)
  belongs_to :user
  
# next line added 12 jul 17 for uploading images (lesson/challenge 16)
  mount_uploader :picture, PictureUploader
  
end
