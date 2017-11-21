class HamperItem < ApplicationRecord
    belongs_to :hamper
    has_one :product
end
