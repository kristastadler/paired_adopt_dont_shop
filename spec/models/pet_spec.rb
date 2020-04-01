require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :image}
    it {should validate_presence_of :status}
    it {should validate_inclusion_of(:age).in_range(1..25)}
    it {should validate_inclusion_of(:sex).in_array(["Male", "Female", "male", "female"])}
    it {should validate_numericality_of(:age).is_greater_than(0)}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end
end
