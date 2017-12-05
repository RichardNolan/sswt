class ProductCategory < ApplicationRecord
    #has_many :products
    #has_many :categories

    belongs_to :product 	# has FK 'product_id'
    belongs_to :category 	# has FK 'category_id'

end
