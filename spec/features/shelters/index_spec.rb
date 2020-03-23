require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do 
  describe "when I visit /shelters" do
    it "then I see the name of each shelter in the system." do 
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

      visit '/shelters'

      within "#shelter-#{shelter_1.id}" do 
        expect(page).to have_link(shelter_1.name)
      end

      within "#shelter-#{shelter_2.id}" do 
        expect(page).to have_link(shelter_2.name)
      end 

      within "#shelter-#{shelter_3.id}" do 
        expect(page).to have_link(shelter_3.name)
        click_on(shelter_3.name)
      end
      
      expect(current_path).to eq("/shelters/#{shelter_3.id}")
    end
    
    it "then I see a link to Edit Shelter info." do 
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

      visit '/shelters'

      within "#shelter-#{shelter_1.id}" do 
        expect(page).to have_link("Update Shelter")
      end

      within "#shelter-#{shelter_2.id}" do 
        expect(page).to have_link("Update Shelter")
      end 

      within "#shelter-#{shelter_3.id}" do 
        expect(page).to have_link("Update Shelter")
        click_on "Update Shelter"
      end
      
      fill_in :name, with: "Johil's Shelter"
      fill_in :address, with: "432 Real St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80201
      click_on "Submit"

      expect(page).to have_content("JOHIL'S SHELTER")
      within '#shelter-info' do 
        expect(page).to have_content("432 Real St.")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content("80201")
      end
    end 

    it "then I see a link to Delete Shelter accompanying each shelter and it can delete the shelter." do 
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

      visit '/shelters'

      within "#shelter-#{shelter_1.id}" do 
        expect(page).to have_link("Delete Shelter")
      end

      within "#shelter-#{shelter_2.id}" do 
        expect(page).to have_link("Delete Shelter")
      end 

      within "#shelter-#{shelter_3.id}" do 
        expect(page).to have_link("Delete Shelter")
        click_on "Delete Shelter"
      end

      expect(page).to have_no_content(shelter_3.name)
    end 
  end
end