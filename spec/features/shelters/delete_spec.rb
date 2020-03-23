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