require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I visit a pets show page" do
    it "I see a link to view all applications for the pet and when I click the link it takes me to the pets applications show page where I see a list of all the names, as links, of applicants for this pet" do
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
                        shelter: shelter_1)

      nova = Pet.create(name: "Nova",
                        age: "10",
                        sex: "Female",
                        status: "Adoptable",
                        image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                        shelter: shelter_1)

      roomba = Pet.create(name: "Roomba",
                        age: "7",
                        sex: "Male",
                        status: "Pending Adoption",
                        image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                        shelter: shelter_1)

    visit "/pets/#{luna.id}"
    click_button "Add to Favorites"
    visit "/pets/#{roomba.id}"
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

    visit "/applications/new"

    check "#{roomba.name}"
    fill_in :name, with: "Peter Jones"
    fill_in :address, with: "This is an address"
    fill_in :city, with: "City"
    fill_in :state, with: "CO"
    fill_in :zip, with: "01532"
    fill_in :phone_number, with: "303-123-4785"
    fill_in :description, with: "I want a pet"

    click_button "Submit"

    visit "/pets/#{luna.id}"

    click_link "See all applicants for this pet"

    expect(current_path).to eq("/pets/#{luna.id}/applications")
    expect(page).to have_content("Joe Smith")
    expect(page).to_not have_content("Peter Jones")

    visit "/pets/#{roomba.id}"

    click_link "See all applicants for this pet"

    expect(current_path).to eq("/pets/#{roomba.id}/applications")
    expect(page).to have_content("Peter Jones")
    expect(page).to_not have_content("Joe Smith")
    end
  end

  describe "when I visit a pets applicants show page and there are no applications for the pet" do
    it "shows a message that there are no applications for this pet yet" do

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
                        shelter: shelter_1)

    visit "/pets/#{luna.id}/applications"

    expect(page).to have_content("There are no applications for this pet, yet.")
  end
end


end
