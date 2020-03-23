require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I access different pages" do 
    it "then I see a welcome page." do
      visit "/"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")

      visit "/pets"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index") 

      visit "/shelters"

      expect(page).to have_link("Pets Index")
      expect(page).to have_link("Shelters Index")
    end
  end 
end 