# firehose track 5, lesson 10 - file created 11 jul 17 for connecting a gram to a user

class AlterGramsAddUserId < ActiveRecord::Migration[5.1]
  
  def change
    add_column :grams, :user_id, :integer
    add_index :grams, :user_id
  end
  
end
