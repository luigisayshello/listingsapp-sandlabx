class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :listings, dependent: :destroy
  #has_many, 1 user can have x listings. But listings can have only 1 User, so listingsmodel belong_to :Users
  #:Destroy:If a user is destroyed, his listings will be too.

end
