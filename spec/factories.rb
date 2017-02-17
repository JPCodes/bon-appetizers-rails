FactoryGirl.define do
  factory :user, class: User do
    sequence(:email){|n| "user#{n}@factory.com" }
    password('anonymous')
  end

  factory :product, class: Product do
    title('Fish Delish')
    description('Our signature dish')
    price(100.50)
    image Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/test_photo.jpg", "image/jpg")
    # File.new("#{Rails.root}/spec/support/fixtures/image.jpg")
  end

  factory :review, class: Review do
    user
    product
    content('This was great!')
  end
end
