require 'rails_helper'

  RSpec.describe "As a visitor" do
    describe "can visit an applications show page and see a link to approve the application for each pet in the application" do
      describe "after clicking Approve Application they are returned to the pet show page where the pet's status has changed to pending adoption" do
        it "and the pet is shown as on hold for the applicant" do

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

      visit "/pets/#{luna.id}"
      click_button "Add to Favorites"
      visit "/pets/#{nova.id}"
      click_button "Add to Favorites"

      visit "/applications/new"

      check "#{luna.name}"
      check "#{nova.name}"
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


      within "#applicationpet-#{luna.id}" do
        expect(page).to have_link("Approve Application")
      end

      within "#applicationpet-#{nova.id}" do
        click_link("Approve Application")
      end

      expect(current_path).to eq("/pets/#{nova.id}")

      expect(page).to have_content("Pending Adoption")
      expect(page).to_not have_content("Adoptable")
      expect(page).to have_content("On hold for Joe Smith")

      end
    end
  end
end

RSpec.describe "I can visit an application show page for an application with more than one pet" do
  it "and approve the application for any number of those pets" do

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

  visit "/pets/#{luna.id}"
  click_button "Add to Favorites"
  visit "/pets/#{nova.id}"
  click_button "Add to Favorites"

  visit "/applications/new"

  check "#{luna.name}"
  check "#{nova.name}"
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

  within "#applicationpet-#{luna.id}" do
    expect(page).to have_link("Approve Application")
  end

  within "#applicationpet-#{nova.id}" do
    click_link("Approve Application")
  end

  expect(current_path).to eq("/pets/#{nova.id}")

  expect(page).to have_content("Pending Adoption")
  expect(page).to_not have_content("Adoptable")
  expect(page).to have_content("On hold for Joe Smith")

  visit "/applications/#{application.id}"

  within "#applicationpet-#{luna.id}" do
    click_link("Approve Application")
  end

  expect(current_path).to eq("/pets/#{luna.id}")

  expect(page).to have_content("Pending Adoption")
  expect(page).to_not have_content("Adoptable")
  expect(page).to have_content("On hold for Joe Smith")

  end

  it "I cannot see approve application if any of the pet's status equals Adoption Pending." do
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

    visit "/pets/#{luna.id}"
    click_button "Add to Favorites"
    visit "/pets/#{nova.id}"
    click_button "Add to Favorites"

    visit "/applications/new"

    check "#{luna.name}"
    check "#{nova.name}"
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

    within "#applicationpet-#{luna.id}" do
      expect(page).to have_link("Approve Application")
      click_link("Approve Application")
    end

    visit "/applications/#{application.id}"

    within "#applicationpet-#{luna.id}" do
      expect(page).to_not have_link("Approve Application")
    end

    within "#applicationpet-#{nova.id}" do
      expect(page).to have_link("Approve Application")
    end
  end 
end
