class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :content, presence: true

  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships

  belongs_to :user
end
