class ProducerImage < ApplicationRecord
    belongs_to :producer  	# has FK producer_id

    mount_uploader :src, PictureUploader # mounting the PictureUploader on the src field of the ProducerImage
end
