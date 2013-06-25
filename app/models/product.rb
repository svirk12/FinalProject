class Product < ActiveRecord::Base
  attr_accessible :title, :description, :value, :image
  
  #define associations
  has_many :comments
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  #define validation
  validates :title, :presence => true
  scope :created_at_order, order('created_at DESC')

  #return full name of post's owner
  def product_user_name
    self.user.full_name
  end
  
  def product_logo
    self.image.present? ? self.image_url(:thumb) : "/assets/default.jpg"
  end

  def product_image
    self.image.present? ? self.image_url(:large) : "/assets/product.jpg"
  end
  
end
