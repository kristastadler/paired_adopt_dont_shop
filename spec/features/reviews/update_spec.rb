require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit a Shelter Show page and the click Edit Review link" do 
    it "then I'm taken to a form with pre-populated fields, I can update any of the fields, submit the changes, and see those changes on Shelter Show page." do 
      shelter_1 = Shelter.create!(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada", 
                                 state: "CO",
                                 zip: 80003)
      
      review_1 = Review.create!(title: "Great shelter",
                               rating: 5,
                               content: "This is a great shelter.",
                               image: "https://i.pinimg.com/474x/cb/36/90/cb3690e7d9bf87c612f272a9dcbe6c2b--dog-kennel-outside-outdoor-dog-kennels.jpg",
                               shelter: shelter_1)
      
      review_2 = Review.create!(title: "Good shelter",
                               rating: 4,
                               content: "This is a good shelter.",
                               shelter: shelter_1)
      
      review_3 = Review.create!(title: "Ok shelter",
                               rating: 3,
                               content: "This is an ok shelter.",
                               shelter: shelter_1)

      visit "/shelters/#{shelter_1.id}"

      within "#review-#{review_1.id}" do 
        expect(page).to have_link("Edit Review")
      end
      
      within "#review-#{review_2.id}" do 
        expect(page).to have_link("Edit Review")
      end

      within "#review-#{review_3.id}" do 
        expect(page).to have_link("Edit Review")
        click_on "Edit Review"
      end

      fill_in :title, with: "Awesome shelter"
      fill_in :rating, with: 5
      fill_in :content, with: "I love this shelter!"
      fill_in :image, with: "https://i.pinimg.com/474x/d9/b0/93/d9b09371c75d563b2a552d6db33020aa--shade-for-dogs-dog-shade-ideas.jpg"
      click_on "Submit"

      review_3.reload

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
       within "#review-#{review_3.id}" do 
        expect(page).to have_content(review_3.title)
        expect(page).to have_content(review_3.rating)
        expect(page).to have_content(review_3.content)
        expect(page).to have_css("img[src*='#{review_3.image}']")
        expect(page).to have_link("Edit Review")

        expect(page).to have_no_content("Ok shelter")
        expect(page).to have_no_content("3")
        expect(page).to have_no_content("This is an ok shelter.")
      end
    end 

    it "then I see the form pre-filled with data." do
      shelter_1 = Shelter.create!(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada", 
                                 state: "CO",
                                 zip: 80003)
      
      review_1 = Review.create!(title: "Great shelter",
                               rating: 5,
                               content: "This is a great shelter.",
                               image: "https://i.pinimg.com/474x/cb/36/90/cb3690e7d9bf87c612f272a9dcbe6c2b--dog-kennel-outside-outdoor-dog-kennels.jpg",
                               shelter: shelter_1)
      
      review_2 = Review.create!(title: "Good shelter",
                               rating: 4,
                               content: "This is a good shelter.",
                               shelter: shelter_1)
      
      review_3 = Review.create!(title: "Ok shelter",
                               rating: 3,
                               content: "This is an ok shelter.",
                               shelter: shelter_1)

      visit "/shelters/#{shelter_1.id}"

      within "#review-#{review_3.id}" do 
        expect(page).to have_link("Edit Review")
        click_on "Edit Review"
      end

      expect(page).to have_selector("input[value='Ok shelter']")
      expect(page).to have_selector("input[value='3']")
      expect(page).to have_selector("input[value='This is an ok shelter.']")
      expect(page).to have_selector("input[value='No image added']")
    end
  end 
end