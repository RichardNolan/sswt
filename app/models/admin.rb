class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, 
  # :recoverable, :rememberable,  and :omniauthable

  devise :database_authenticatable, :trackable, :validatable, :registerable
end
