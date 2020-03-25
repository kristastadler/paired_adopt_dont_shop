require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters/:id" do

    it "I see a link to add a new review for the shelter" do
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

    expect(page).to have_link 'Add New Review', href: "/shelters/#{shelter_1.id}/reviews/new"
    end
  end

    it "I click the Add New Review link and can complete a form to add a new review" do
    shelter_1 = Shelter.create(name: "Jordan's Shelter",
                           address: "123 Fake St.",
                           city: "Arvada",
                           state: "CO",
                           zip: 80003)

    visit "/shelters/#{shelter_1.id}"
    click_on "Add New Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in :title, with: "Lovely animal shelter"
    fill_in :rating, with: 3
    fill_in :content, with: "Adopted a new dog"
    fill_in :image, with: "https://i.chzbgr.com/full/9059638528/hADE94BC4/fluffy-thailand-cat-cat"

    click_on "Submit"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    click_on "Add New Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    fill_in :title, with: "Great animals"
    fill_in :rating, with: 5
    fill_in :content, with: "Easy process"

    click_on "Submit"

    expect(page).to have_content("Lovely animal shelter")
    expect(page).to have_content("Great animals")
    expect(page).to have_content("Adopted a new dog")
    expect(page).to have_content("Easy process")
    expect(page).to have_content("No image added")
    expect(page).to have_css("img[src*='https://i.chzbgr.com/full/9059638528/hADE94BC4/fluffy-thailand-cat-cat']")
  end
end
