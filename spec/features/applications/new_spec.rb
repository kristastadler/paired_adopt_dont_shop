require 'rails_helper'

RSpec.describe "As a visitor" do
  it "can fill out an application form, click submit, and then visit the application's show page to see the application" do
    shelter_1 = Shelter.create(name: "Jordan's Shelter",
                               address: "123 Fake St.",
                               city: "Arvada",
                               state: "CO",
                               zip: 80003)

    luna = Pet.create(name: "Luna",
                      age: "5",
                      sex: "Female",
                      status: "Adoptable",
                      image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
                      shelter: shelter_1)

    nova = Pet.create(name: "Nova",
                      age: "10",
                      sex: "Female",
                      status: "Adoptable",
                      image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                      shelter: shelter_1)

    roomba = Pet.create(name: "Roomba",
                      age: "7",
                      sex: "Male",
                      status: "Pending Adoption",
                      image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                      shelter: shelter_1)

    visit "/pets/#{luna.id}"
    click_button "Add to Favorites"

    visit "/pets/#{roomba.id}"
    click_button "Add to Favorites"

    visit "/applications/new"

    check "#{luna.name}"
    check "#{roomba.name}"
    fill_in :name, with: "Joe Smith"
    fill_in :address, with: "123 Main Street"
    fill_in :city, with: "Anytown"
    fill_in :state, with: "CO"
    fill_in :zip, with: "01532"
    fill_in :phone_number, with: "303-123-4567"
    fill_in :description, with: "I want a dog"

    click_button "Submit"
    
    application = Application.last

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.phone_number)
    expect(page).to have_content(application.description)
    expect(page).to have_link(luna.name)
    expect(page).to have_link(roomba.name)
    expect(page).to_not have_link(nova.name)
    end
  end





  # As a visitor
  # When I visit an applications show page "/applications/:id"
  # I can see the following:
  #
  # name
  # address
  # city
  # state
  # zip
  # phone number
  # Description of why the applicant says they'd be a good home for this pet(s)
  # names of all pet's that this application is for (all names of pets should be links to their show page)

# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
#
# Name
# Address
# City
# State
# Zip
# Phone Number
# Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
