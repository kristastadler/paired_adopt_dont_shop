require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I access different pages" do
    it "then I see a pets index, a shelter index, and a favorites indicator." do
      visit "/"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Favorites")

      click_link("Favorites")
      expect(current_path).to eq("/favorites")

      visit "/pets"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Favorites")

      click_link("Favorites")
      expect(current_path).to eq("/favorites")

      visit "/shelters"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Favorites")

      click_link("Favorites")
      expect(current_path).to eq("/favorites")
    end
  end

  describe "when I add a pet to my favorites" do
    it "increases the Favorites count in my navigation bar by one" do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                              address: "123 Fake St.",
                              city: "Arvada",
                              state: "CO",
                              zip: 80003)

      luna = Pet.create(name: "Luna",
                          age: "5",
                          sex: "Female",
                          status: "Adoptable",
                          image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
                          description: "Very good dog.",
                          shelter: shelter_1)
      pete = Pet.create(name: "Pete",
                          age: "4",
                          sex: "Male",
                          status: "Adoptable",
                          image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
                          description: "Very good boy.",
                          shelter: shelter_1)

      visit "/pets/#{luna.id}"

      click_button "Add to Favorites"
      expect(page).to have_content "Favorites: 1"

      visit "/pets/#{pete.id}"

      click_button "Add to Favorites"
      expect(page).to have_content "Favorites: 2"
    end
  end
end
