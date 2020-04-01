class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates_length_of :zip, is: 5

  has_many :pets, dependent: :destroy
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

  def avg_review
    if self.reviews.empty?
      0
    else 
      reviews.average(:rating)
    end
  end

  def app_count
    pets.joins(:application_pets).count
  end

end
