require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I access different pages" do
    it "then I see a pets index, a shelter index, and a favorites indicator." do
      visit "/"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Favorites")

      click_link("Favorites")
      expect(current_path).to eq("/favorites")

      visit "/pets"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Favorites")

      click_link("Favorites")
      expect(current_path).to eq("/favorites")

      visit "/shelters"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
      expect(page).to have_link("Favorites")

      click_link("Favorites")
      expect(current_path).to eq("/favorites")

    end
  end
end
