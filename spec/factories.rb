# firehose track 5, lesson 11 - file created 11 jul 17 for installing factory girl

FactoryGirl.define do
  factory :comment do
    
  end
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
  
  factory :gram do
    message "hello"
    
    # next line added 12 jul 17 for image validation (lesson 17)
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png'), 'image/png') }
    
    association :user
  end
  
end
