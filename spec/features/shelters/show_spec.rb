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
  end

end
