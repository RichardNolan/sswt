class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
    #has_many :product_likes
    has_many :hampers 			# customer PK used many times in hampers

    # many to many 
    has_many :product_likes		# customer PK used many times on product_like
    has_many :products, :through => :product_likes	
    
end
