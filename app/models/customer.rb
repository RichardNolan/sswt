class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
  #has_many :product_likes
  has_many :hampers 			# customer PK used many times in hampers

  # Customer Likes Product - many to many 
  has_and_belongs_to_many :product
    
end
