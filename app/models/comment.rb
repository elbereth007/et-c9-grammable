# firehose track 5, lesson 18 - file created 12 jul 17 for comments

class Comment < ApplicationRecord
  belongs_to :gram
  belongs_to :user
end
