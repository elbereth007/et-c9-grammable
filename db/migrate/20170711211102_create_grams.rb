# firehose track 5, lesson 7 - file created 11 jul 17 for adding grams in db

class CreateGrams < ActiveRecord::Migration[5.1]
  def change
    create_table :grams do |t|
      
# next line added 11 jul 17 for adding grams in db (lesson 7)
      t.text :message

      t.timestamps
    end
  end
end
