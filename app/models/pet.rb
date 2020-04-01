class Pet < ApplicationRecord
  validates_presence_of :name, :age, :sex, :image, :status
  belongs_to :shelter
  validates_inclusion_of :age, in: 1..25
  validates_numericality_of :age, greater_than: 0
  validates_inclusion_of :sex, in: ["Male", "Female", "male", "female"]
  has_many :application_pets
  has_many :applications, through: :application_pets
end
