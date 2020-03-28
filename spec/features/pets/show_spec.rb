require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I visit /pets/:id" do
    it "then I see a page with that pet's image, name, description, age, sex, and status." do
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

      visit "/pets/#{luna.id}"

      expect(page).to have_css("img[src*='#{luna.image}']")
      expect(page).to have_content("#{luna.name.upcase}'S SHOW PAGE")
      expect(page).to have_content("Description: #{luna.description}")
      expect(page).to have_content("Age: #{luna.age}")
      expect(page).to have_content("Gender: #{luna.sex}")
      expect(page).to have_content("Adoption Status: #{luna.status}")
    end
  end

  describe 'When a user favorites a pet to their favorites' do
  it 'displays a flash message the indicates that the pet has been added to your favorites list' do
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

    visit "/pets/#{luna.id}"
    click_button("Add to Favorites")

    expect(page).to have_content("#{luna.name} has been added to your favorites list.")
    end
  end

describe 'Once a user adds a pet to their favorites' do
    it 'the Add to Favorites button is replaced by a Remove Pet from Favorites link' do
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

      visit "/pets/#{luna.id}"
      click_button("Add to Favorites")
      expect(current_path).to eq("/pets/#{luna.id}")
      expect(page).to_not have_button("Add to Favorites")
      click_button("Remove from Favorites")
      expect(current_path).to eq("/pets/#{luna.id}")
      expect(page).to have_content("#{luna.name} has been removed from your favorites list.")
      expect(page).to_not have_button("Remove from Favorites")
      expect(page).to have_button("Add to Favorites")
      expect(page).to have_content("Favorites: 0")

    end
  end
end
