class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  devise :database_authenticatable, :validatable

  belongs_to :company

  has_many :articles, class_name: "Blorgh::Article", dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  PROFILE_FIELDS = %i[name age dob bio phone address city zip country].freeze
end
