class Producer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :products			# PK used many times in products
    has_many :producer_images  	# PK used many times in producer_images

    accepts_nested_attributes_for :producer_images, allow_destroy: true, reject_if: proc {|attributes| attributes['src'].blank?}
    
end
