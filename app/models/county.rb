class County < ApplicationRecord
    #belongs_to :producer 	# county has no FK 'producer_id'
    #belongs_to :customer 	# county has no FK 'customer_id'
    has_many :producers		# county PK used many times in Producer
    has_many :customers		# county PK used many times in Customer
end
