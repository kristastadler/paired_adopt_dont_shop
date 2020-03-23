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
end