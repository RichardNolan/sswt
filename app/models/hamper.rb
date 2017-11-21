class Hamper < ApplicationRecord
    belongs_to :customer
    belongs_to :order_item
    has_many :hamper_items
end
