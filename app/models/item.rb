class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  
  validates :name, :info, :price, :image, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, presence: true
  validates :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, numericality: { other_than: 1 }
  validates :price, inclusion: { in: 300..9999999 }
  validates :price, format: { with: /\A[0-9]+\z/}
end