require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I add a pet to favorites and go to Favorites Index page" do
    it "then I see all pets I've favorited including their name (as link to pet's show page) and image." do
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

      visit "/pets/#{nova.id}"
      click_button "Add to Favorites"

      visit "/favorites"

      expect(page).to have_no_content(roomba.name)
      expect(page).to have_no_content("There are no favorited pets to display at this time.")


      within "#favpet-#{luna.id}" do
        expect(page).to have_content(luna.name)
        expect(page).to have_css("img[src*='#{luna.image}']")
      end

      within "#favpet-#{nova.id}" do
        expect(page).to have_content(nova.name)
        expect(page).to have_css("img[src*='#{nova.image}']")
        click_on(nova.name)
      end

      expect(current_path).to eq("/pets/#{nova.id}")
      expect(page).to have_no_content(roomba.name)
      expect(page).to have_no_content("There are no favorited pets to display at this time.")
    end
  end

  describe "when I visit the Favorites Index page without favoriting any pets" do
    it "then I see a message saying there are no pets to display." do
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

      visit "/favorites"

      expect(page).to have_content("There are no favorited pets to display at this time.")
    end
  end

  describe "when I visit the Favorites Index page" do
    it "then I see a button next to each favorited pet allowing me to remove the pet from my favorites." do

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

      visit "/favorites"

      within "#favpet-#{luna.id}" do
      click_button "Remove from Favorites"
      end

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Favorites: 0")
    end
  end

  describe "when I visit the Favorites Index page" do
    it "then I can remove all of favorited pets at once." do

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

      visit "/favorites"

      click_link "Remove All Favorite Pets"


      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Favorites: 0")
    end

    it "then I see a link for adopting my favorited pets and when I click that link I'm taken to a new application form" do

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

      visit "/favorites"

      click_link "Apply to Adopt Favorite Pets"

      expect(current_path).to eq("/applications/new")
    end

    it "I see a section on the page that has a list of pet names, as links to their show pages, that have at least one application on them." do
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

      visit "/pets/#{nova.id}"
      click_button "Add to Favorites"

      visit "/applications/new"
      check "#{luna.name}"
      check "#{roomba.name}"
      fill_in :name, with: "Joe Smith"
      fill_in :address, with: "123 Main Street"
      fill_in :city, with: "Anytown"
      fill_in :state, with: "CO"
      fill_in :zip, with: "01532"
      fill_in :phone_number, with: "303-123-4567"
      fill_in :description, with: "I want a dog"

      click_button "Submit"

      visit "/favorites"

      within "#openapplications" do
        expect(page).to have_link("Luna")
        expect(page).to have_link("Roomba")
        expect(page).to_not have_link("Nova")
      end
    end

    it "after favoriting a pet then deleting that pet, I should see it deleted from my favorites, too." do 
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

      visit "/pets/#{nova.id}"
      click_button "Add to Favorites"

      visit "/pets"
      
      within "#pet-#{roomba.id}" do
        click_on "Delete Pet"
      end

      visit "/favorites"

      expect(page).to have_content(nova.name)
      expect(page).to have_content(luna.name)
      expect(page).to_not have_content(roomba.name)
    end
  end
end
