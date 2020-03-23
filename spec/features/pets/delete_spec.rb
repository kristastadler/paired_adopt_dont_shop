require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit a Pet Show page" do 
    it "then I click a Delete Pet link, and I see the pet is deleted on the Index Page." do 
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

      nova = Pet.create(name: "Nova",
                        age: "10",
                        sex: "Female",
                        status: "Pending Adoption",
                        image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                        description: "Amazingly good dog.",
                        shelter: shelter_1)

      visit "/pets/#{rhombus.id}"

      click_on "Delete Pet"

      expect(current_path).to eq("/pets")
      expect(page).to have_no_content(rhombus.name)
      expect(page).to have_no_content(rhombus.age)
    end 
  end 
end 