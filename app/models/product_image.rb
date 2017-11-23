class ProductImage < ApplicationRecord
    belongs_to :product 	# has FK product_id

    mount_uploader :src, PictureUploader # mounting the PictureUploader on the src field of the ProductImage
end
