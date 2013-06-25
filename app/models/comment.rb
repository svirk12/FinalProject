class Comment < ActiveRecord::Base
  attr_accessible :content
  
  #define associations
  belongs_to :product
  delegate :user, :to => :product
  
  #define validation
  validates :content, :presence => true
  scope :created_at_order, order('created_at DESC')
  
  def comment_user
    self.user.full_name rescue ''
  end
  
  #fetch owner of comment
  def is_owner?(user_id)
    return (self.user.id === user_id)
  end
end
