require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a Shelter Show page" do
    it "then I see a link to delete each review, and, when clicked, the reviews are deleted." do
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
        expect(page).to have_link("Delete Review")
      end

      within "#review-#{review_2.id}" do
        expect(page).to have_link("Delete Review")
        click_on "Delete Review"
      end

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_no_content(review_2.title)
      expect(page).to have_no_content(review_2.rating)
      expect(page).to have_no_content(review_2.content)
      expect(page).to have_no_content(review_2.image)
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_1.image)
    end
  end
end