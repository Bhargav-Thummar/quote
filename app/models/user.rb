class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :validatable

  belongs_to :company

  has_many :notifications, as: :recipient

  PROFILE_FIELDS = %i[name age dob bio phone address city zip country].freeze

end
