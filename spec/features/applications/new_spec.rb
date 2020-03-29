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

  it "I cannot fill out a blank application and proceed." do
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

    visit "/pets/#{nova.id}"
    click_button "Add to Favorites" 
    
    visit "/pets/#{roomba.id}"
    click_button "Add to Favorites"

    visit "/applications/new"

    check "#{luna.name}"
    check "#{roomba.name}"
    fill_in :name, with: ""
    fill_in :address, with: "123 Main Street"
    fill_in :city, with: "Anytown"
    fill_in :state, with: "CO"
    fill_in :zip, with: "01532"
    fill_in :phone_number, with: "303-123-4567"
    fill_in :description, with: "I want a dog"

    click_button "Submit"

    expect(page).to have_content("You must fill out all fields in order to submit this application.")
  end
end