class Order < ApplicationRecord
    belongs_to :customer	# has FK customer_id
    
    # many to many
    has_many :order_items	# PK used many times in order_items
    has_many :hampers, :through => :order_items
end
