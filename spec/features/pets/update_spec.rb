require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit a Pet Show page" do 
    it "I click a link to Update Pet, fill out the form, click Submit, and redirect back to Pet Show page." do 
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

      rhombus = Pet.create(name: "Rhombus",
                           age: "2",
                           sex: "Male",
                           status: "Adoptable",
                           image: "http://cdn.akc.org/content/article-body-image/keeshond_dog_pictures_2.jpg",
                           description: "Extremely good dog.",
                           shelter: shelter_1)

      visit "/pets/#{rhombus.id}"

      click_on "Update Pet"

      expect(page).to have_link(rhombus.name)
      fill_in :image, with: "http://cdn.akc.org/content/article-body-image/golden_retriever_puppy_sleeping_dog_pictures.jpg"
      fill_in :name, with: "Triangle"
      fill_in :description, with: "Acute dog!"
      fill_in :age, with: "4"
      fill_in :sex, with: "Female"
      click_on "Submit"

      expect(current_path).to eq("/pets/#{rhombus.id}")
      expect(page).to have_css("img[src*='http://cdn.akc.org/content/article-body-image/golden_retriever_puppy_sleeping_dog_pictures.jpg']")
      expect(page).to have_content("TRIANGLE'S")
      expect(page).to have_content("Acute dog!")
      expect(page).to have_content("4")
      expect(page).to have_content("Female")
      expect(page).to have_no_content(luna.name)
    end 

    it "and click link to Update Pet, fill out incomplete information, and I get a flash message with fields I'm missing." do
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

      rhombus = Pet.create(name: "Rhombus",
                           age: "2",
                           sex: "Male",
                           status: "Adoptable",
                           image: "http://cdn.akc.org/content/article-body-image/keeshond_dog_pictures_2.jpg",
                           description: "Extremely good dog.",
                           shelter: shelter_1)

      visit "/pets/#{rhombus.id}"

      click_on "Update Pet"

      fill_in :image, with: "http://cdn.akc.org/content/article-body-image/golden_retriever_puppy_sleeping_dog_pictures.jpg"
      fill_in :name, with: "Triangle"
      fill_in :description, with: "Acute dog!"
      fill_in :age, with: "4"
      fill_in :sex, with: ""
      click_on "Submit"

      expect(page).to have_content("Sex can't be blank")
      expect(current_path).to eq("/pets/#{rhombus.id}/edit")
    end 
  end 
end