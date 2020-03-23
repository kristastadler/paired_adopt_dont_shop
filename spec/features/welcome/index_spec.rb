require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I access the root directory" do 
    it "then I see a welcome page." do
      visit "/"

      expect(page).to have_content("Welcome to Adopt Don't Shop!")
    end 
  end 
end 