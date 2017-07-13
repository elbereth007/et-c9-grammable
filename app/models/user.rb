class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
# next line added 11 jul 17 for connecting a gram with a user (lesson 10)
         has_many :grams
# next line added 12 jul 17 for comments (lesson 18)
         has_many :comments
end
