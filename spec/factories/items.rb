FactoryBot.define do
  factory :item do

    name                   {'hoge'}
    info                   {'hoge'}
    price                  {'300'}
    category_id            {'2'}
    sales_status_id        {'2'}
    shipping_fee_status_id {'2'}
    prefecture_id          {'2'}
    scheduled_delivery_id  {'2'}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
