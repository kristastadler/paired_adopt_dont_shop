require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do 
  describe "when I visit the Shelters index page" do
    it "then I see a link to create a new shelter." do 
      visit "/shelters"

      expect(page).to have_link("New Shelter")
    end
  end

  describe "when I click the New Shelter link" do 
    it "then I am taken to '/shelters/new' where I see a form for a new shelter." do 
      visit "/shelters"

      click_on "New Shelter"

      expect(current_path).to eq("/shelters/new")
    end 
  end 

  describe "when I fill out the New Shelter form and click Create Shelter" do 
    it "then a new shelter is created and I am redirected to the Shelter Index page where I see the new Shelter listed." do 
      visit "/shelters"

      click_on "New Shelter"

      fill_in :name, with: "Jordan's Shelter"
      fill_in :address, with: "123 Fake St."
      fill_in :city, with: "Arvada"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80003
      click_on "Create Shelter"
      
      expect(page).to have_content("Jordan's Shelter")
    end 
  end 
end