class OrderAddress

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :addresses, :building_name, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "Postal code Input correctly" }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "Phone number Input correctly" }
    validates :token
    validates :city
    validates :addresses
    validates :user_id
    validates :item_id
  end

    validates :prefecture_id, numericality: { other_than: 1 ,message: "Prefecture Select" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    DeliveryAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end