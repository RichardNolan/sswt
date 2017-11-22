class OrderItem < ApplicationRecord
    #has_one :hamper
    belongs_to :order 	# has FK order_id
    belongs_to :hamper 	# has FK hamper_id
end
