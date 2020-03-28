require 'rails_helper'

RSpec.describe Favorite do
  describe "#total_count" do
    it "can calculate the total number of favorites it holds" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 1
        })

    expect(favorites.total_count).to eq(2)
    end
  end


  describe "#add_pet" do
    it "adds a pet to its contents" do
      favorites = Favorite.new({
        '1' => 0,
        '2' => 0
        })
    favorites.add_pet(1)
    favorites.add_pet(2)

    expect(favorites.contents).to eq({'1' => 1, '2' => 1})
    end

    it "adds a pet that hasn't been added yet" do
      favorites = Favorite.new({
        '1' => 0,
        '2' => 0
        })
      favorites.add_pet(1)
      favorites.add_pet(2)
      favorites.add_pet(3)

    expect(favorites.contents).to eq({'1' => 1, '2' => 1, '3' => 1})
  end
  end

  describe "delete_pet" do
    it "deletes a pet to its contents" do
      favorites = Favorite.new({
        '1' => 1,
        '2' => 0
        })
    favorites.delete_pet(1)


    expect(favorites.contents).to eq({'1' => 0, '2' => 0})
    end
  end 

  describe "#count_of" do
  it "returns the count of all pets in the favorites" do
    favorites = Favorite.new({})

    expect(favorites.count_of(5)).to eq(0)
  end
end
end
