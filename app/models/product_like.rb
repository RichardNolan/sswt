class ProductLike < ApplicationRecord
    belongs_to :product 		# product_like has FK product_id
    belongs_to :customer		# product_like has FK customer_id
end
