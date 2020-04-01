class Review < ApplicationRecord 
  validates_presence_of :title, :rating, :content
  validates_inclusion_of :rating, in: 1..5
  belongs_to :shelter
end