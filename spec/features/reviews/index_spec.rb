require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters/:id" do
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

    within "#review-#{review_1.id}" do
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content("No image added")
    end

    within "#review-#{review_2.id}" do
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_css("img[src*='#{review_2.image}']")
    end
  end
end
end
