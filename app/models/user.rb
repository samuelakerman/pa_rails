class User < ApplicationRecord
	has_many :enrollments
	has_many :courses, through: :enrollments
	validates :name, presence: true, length: { minimum: 2, maximum: 20 }
	validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
	validates :username, presence: true, length: { minimum: 2, maximum: 20 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  	has_secure_password
end
