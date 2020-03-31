require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a Shelter Show page" do
    it "then I see and click a link to delete shelter which visbily deletes the shelter from the system." do
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

      shelter_3 = Shelter.create(name: "Hiljo's Shelter",
                                 address: "311 Realfake Ave.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}"

      click_on "Delete Shelter"

      expect(page).to_not have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(shelter_3.name)
    end
  end
end

RSpec.describe "As a visitor", type: :feature do
  it "I cannot delete a shelter if that shelter has approved applications for any of their pets" do
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
                     shelter: shelter_1)

   roomba = Pet.create(name: "Roomba",
                     age: "7",
                     sex: "Male",
                     status: "Pending Adoption",
                     image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                     shelter: shelter_2)

    visit "/pets/#{luna.id}"
    click_button "Add to Favorites"

    visit "/applications/new"

    check "#{luna.name}"
    fill_in :name, with: "Joe Smith"
    fill_in :address, with: "123 Main Street"
    fill_in :city, with: "Anytown"
    fill_in :state, with: "CO"
    fill_in :zip, with: "01532"
    fill_in :phone_number, with: "303-123-4567"
    fill_in :description, with: "I want a dog"

    click_button "Submit"

    application = Application.last

    visit "/applications/#{application.id}"

    within "#applicationpet-#{luna.id}" do
      click_link "Approve Application"
    end

    visit "/shelters/#{shelter_1.id}"
    expect(page).to_not have_link("Delete Shelter")

    visit "/shelters/#{shelter_2.id}"
    expect(page).to have_link("Delete Shelter")

    visit "/shelters"

    within "#shelter-#{shelter_1.id}" do
      expect(page).to_not have_link("Delete Shelter")
    end

    within "#shelter-#{shelter_2.id}" do
      expect(page).to have_link("Delete Shelter")
    end

  end
end

RSpec.describe "As a visitor", type: :feature do
  describe "as long as a shelter doesn't have any pets with a pending status, I can delete the shelter" do
    it "and when the shelter is deleted, all of its pets are deleted, too" do

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
                     shelter: shelter_1)

    roomba = Pet.create(name: "Roomba",
                     age: "7",
                     sex: "Male",
                     status: "Adoptable",
                     image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                     shelter: shelter_1)

    sparky = Pet.create(name: "Sparky",
                    age: "2",
                    sex: "Male",
                    status: "Adoptable",
                    image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                    shelter: shelter_2)



    visit "/shelters/#{shelter_1.id}"

    click_on "Delete Shelter"

    visit "/pets"

    expect(page).to_not have_content(luna.name)
    expect(page).to_not have_content(roomba.name)
    expect(page).to have_content(sparky.name)
  end
end
end

RSpec.describe "As a visitor", type: :feature do
  it "when I delete a shelter, all of it's reviews are deleted, too" do

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
                     shelter: shelter_1)
    review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                   rating: 5,
                                   content: "Staff were so helpful and the process was easy.")
    review_2 = shelter_1.reviews.create(title: "Good experience",
                                   rating: 4,
                                   content: "Happy with this animal shelter",
                                   image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")
    review_3 = shelter_2.reviews.create(title: "Okay experience",
                                  rating: 3,
                                  content: "Meh")

    visit "/shelters/#{shelter_1.id}"
    expect(Review.all.length).to eq(3)

    click_on "Delete Shelter"
    expect(Review.all.length).to eq(1)

  end
end
