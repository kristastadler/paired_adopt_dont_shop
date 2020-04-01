require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit the Shelter Pets index page" do 
    it "I click a link to Create Pet, fill out a form to add new adoptable pet, and see that pet added to Shelter Pets index page." do 
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada", 
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}/pets"

      click_on "Create Pet"
      fill_in :image, with: "http://cdn.akc.org/content/article-body-image/bull_terrier_puppy_dog_picture_.jpg"
      fill_in :name, with: "Bowser"
      fill_in :description, with: "13/10 good boy."
      fill_in :age, with: "3"
      fill_in :sex, with: "Male"
      click_on "Create Pet"

      expect(page).to have_css("img[src*='http://cdn.akc.org/content/article-body-image/bull_terrier_puppy_dog_picture_.jpg']")
      expect(page).to have_content("Bowser")
      expect(page).to have_content("3")
      expect(page).to have_content("Male")
    end 

    it "and click Create Pet, fill out the form with incomplete information, I should see an error message noting the field(s) missing." do 
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada", 
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}/pets"

      click_on "Create Pet"
      fill_in :image, with: "http://cdn.akc.org/content/article-body-image/bull_terrier_puppy_dog_picture_.jpg"
      fill_in :name, with: ""
      fill_in :description, with: "13/10 good boy."
      fill_in :age, with: "3"
      fill_in :sex, with: "Male"
      click_on "Create Pet"

      expect(page).to have_content("Name can't be blank")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")
    end
  end 
end