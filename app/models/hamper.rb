class Hamper < ApplicationRecord
    belongs_to :customer 		# hamper has FK 'customer_id'
    #belongs_to :order_item		# hamper has no FK 'order_item_id'
    
    # many to many
    has_many :hamper_items, dependent: :destroy 		# hamper PK used many times in hamper_item
    has_many :products, :through => :hamper_items

    # many to many
    has_many :order_items 		# hamper PK used many times in order_item 
    has_many :orders, :through => :order_items
end
