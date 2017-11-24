class County < ApplicationRecord
    
    # Relationships ---------------------------------------
    has_many :producers		# county PK used many times in Producer
    has_many :customers		# county PK used many times in Customer


    # Validation Rules ------------------------------------
    validates 	:name,
    			presence: true,
    			length: {maximum: 50},
    			uniqueness: {case_sensitive: false}

end
