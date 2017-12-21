class HamperItem < ApplicationRecord
    belongs_to :hamper 		# hamper_item has FK hamper_id
    #has_one :product 		# hamper_item has FK product_id, should be 'belongs_to :product'
    belongs_to :product 	# hamper_item has FK product_id

    has_one :producer, :through => :product
end
