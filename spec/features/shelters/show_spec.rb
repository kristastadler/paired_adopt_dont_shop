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

    it "I see a list of reviews for that shelter" do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)
      review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                          rating: 5,
                                          content: "Staff were so helpful and the process was easy.")
      review_2 = shelter_1.reviews.create(title: "Good experience",
                                          rating: 4,
                                          content: "Happy with this animal shelter",
                                          image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_css("img[src*='#{review_2.image}']")
    end
  end

  it "I see a link to add a new review for the shelter"
  shelter_1 = Shelter.create(name: "Jordan's Shelter",
                             address: "123 Fake St.",
                             city: "Arvada",
                             state: "CO",
                             zip: 80003)
  review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                      rating: 5,
                                      content: "Staff were so helpful and the process was easy.")
  review_2 = shelter_1.reviews.create(title: "Good experience",
                                      rating: 4,
                                      content: "Happy with this animal shelter",
                                      image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")
  visit "/shelters/#{shelter_1.id}"

  expect(page).to have_link 'Add New Review', href

end
