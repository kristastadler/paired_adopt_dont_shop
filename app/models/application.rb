class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.unique_pets
    unique_pets = []
    Application.all.each do |application|
      application.pets.each do |pet|
        unique_pets << pet
      end
    end
    unique_pets.uniq
  end

end
