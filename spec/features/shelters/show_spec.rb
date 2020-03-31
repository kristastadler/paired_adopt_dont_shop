require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters/:id" do
    it "then I see that shelter's name, address, city, state, and zip." do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name.upcase)
      within "#shelter-info" do
        expect(page).to have_content(shelter_1.address)
        expect(page).to have_content(shelter_1.city)
        expect(page).to have_content(shelter_1.state)
        expect(page).to have_content(shelter_1.zip)
      end
    end

    it "then I see a link to take me to that shelter's pets page /shelters/:id/pets." do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name.upcase)
      within "#shelter-info" do
        expect(page).to have_content(shelter_1.address)
        expect(page).to have_content(shelter_1.city)
        expect(page).to have_content(shelter_1.state)
        expect(page).to have_content(shelter_1.zip)
      end
      expect(page).to have_link("This Shelter's Pets Page")
      click_on("This Shelter's Pets Page")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    end

    it "then I see a Shelter Statistics section that displays shelter stats." do 
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

      nova = Pet.create(name: "Nova",
                        age: "10",
                        sex: "Female",
                        status: "Adoptable",
                        image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                        description: "Amazingly good dog.",
                        shelter: shelter_1)

      review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                    rating: 5,
                                    content: "Staff were so helpful and the process was easy.")

      review_2 = shelter_1.reviews.create(title: "Good experience",
                                          rating: 4,
                                          content: "Happy with this animal shelter",
                                          image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")                    

      review_3 = shelter_1.reviews.create(title: "The experience was average.",
                                          rating: 3,
                                          content: "I did not find a dog.")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Shelter Statistics:")
      expect(page).to have_content("Count of Pets in this Shelter: 2")
      expect(page).to have_content("Average Review Rating: 4")
      expect(page).to have_content("Number of Applications on File: 0")
    end
  end

end
