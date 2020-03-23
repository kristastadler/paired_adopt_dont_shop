require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit '/shelters/:shelter_id/pets'" do 
    it "then I can see each pet's image, name, age, and sex that can be adopted from that shelter " do 
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada", 
                                 state: "CO",
                                 zip: 80003)

      shelter_2 = Shelter.create(name: "Hilary's Shelter",
                                 address: "321 Real Rd.",
                                 city: "Denver", 
                                 state: "CO",
                                 zip: 80301)

      luna = Pet.create(name: "Luna",
                        age: "5",
                        sex: "Female",
                        status: "Adoptable",
                        image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
                        description: "Very good dog.",
                        shelter: shelter_1)

      rhombus = Pet.create(name: "Rhombus",
                        age: "2",
                        sex: "Male",
                        status: "Adoptable",
                        image: "http://cdn.akc.org/content/article-body-image/keeshond_dog_pictures_2.jpg",
                        description: "Extremely good dog.",
                        shelter: shelter_1)     

      nova = Pet.create!(name: "Nova",
                        age: "10",
                        sex: "Female",
                        status: "Pending Adoption",
                        image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                        description: "Amazingly good dog.",
                        shelter: shelter_1)

      roomba = Pet.create(name: "Roomba",
                        age: "7",
                        sex: "Male",
                        status: "Adoptable",
                        image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                        description: "Hilariously good dog.",
                        shelter: shelter_2)


      visit "/shelters/#{shelter_1.id}/pets"
      
      expect(page).to have_content("#{shelter_1.name.upcase} ADOPTABLE PETS INDEX PAGE")
      expect(page).to have_link(shelter_1.name.upcase)
      expect(page).to_not have_content(nova.name)
      expect(page).to_not have_content(roomba.name)
      
      within "#pet-#{luna.id}" do
        expect(page).to have_css("img[src*='#{luna.image}']")
        expect(page).to have_link(luna.name)
        expect(page).to have_content(luna.age)
        expect(page).to have_content(luna.sex)
        expect(page).to have_content("Update Pet")
      end

      within "#pet-#{rhombus.id}" do
        expect(page).to have_css("img[src*='#{rhombus.image}']")
        expect(page).to have_link(rhombus.name)
        expect(page).to have_content(rhombus.age)
        expect(page).to have_content(rhombus.sex)
        expect(page).to have_content("Update Pet")
        click_on(rhombus.name)
      end
      expect(current_path).to eq("/pets/#{rhombus.id}")
      
      visit "/shelters/#{shelter_1.id}/pets"
      click_on(shelter_1.name.upcase)
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end 
  end 
end