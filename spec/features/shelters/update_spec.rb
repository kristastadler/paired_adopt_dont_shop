require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the Shelter show page" do
    it "then I see a link to update the shelter." do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Update Shelter")
    end
  end

  describe "when I click the Update Shelter link" do
    it "then I am taken to '/shelters/:id/edit' where I see a form to edit the shelter." do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}"

      click_on "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    end
  end

  describe "when I fill out the Update Shelter form and click Submit" do
    it "then the shelter info is updated and I am redirected to the Shelter's Show page where I see the shelter's updated info." do
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      visit "/shelters/#{shelter_1.id}"

      click_on "Update Shelter"

      expect(page).to have_link(shelter_1.name)
      fill_in :name, with: "Hilary's Shelter"
      fill_in :address, with: "432 Real St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80201
      click_on "Submit"

      expect(page).to have_content("HILARY'S SHELTER")
      within '#shelter-info' do
        expect(page).to have_content("432 Real St.")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content("80201")
      end
    end
  end

  describe "when I fill out the Update Shelter form but leave one or more fields blank and click Update Shelter" do
    it "then I see a flash message indicating which field(s) I am missing" do

    shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

    visit "/shelters/#{shelter_1.id}"

    click_on "Update Shelter"

    fill_in :name, with: "Jordan's Shelter"
    fill_in :address, with: "123 Main Street"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80003

    click_button "Submit"

    expect(page).to have_content("City can't be blank")


    fill_in :name, with: "Krista's Shelter"
    fill_in :address, with: "123 Fake St."
    fill_in :city, with: "Arvada"
    click_on "Submit"

    expect(page).to have_content("State can't be blank, Zip can't be blank, and Zip is the wrong length (should be 5 characters)")
    end
  end
end
