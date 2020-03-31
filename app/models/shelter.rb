class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pets
  has_many :reviews, dependent: :destroy

  def count_approved_applications
    approved_applications = 0
    self.pets.each do |pet|
      if pet.approved_application != nil
        approved_applications += 1
      end
    end
    approved_applications
  end

end
