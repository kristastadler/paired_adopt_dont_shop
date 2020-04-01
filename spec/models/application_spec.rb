require 'rails_helper'

describe Application, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :description}
  end

  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'class methods' do
      it '.unique_pets' do

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
      application_1 = luna.applications.create!(name: "Joe Smith",
                                    address: "123 Fake Street",
                                    city: "Anywhere",
                                    state: "CO",
                                    zip: "12345",
                                    phone_number: "1234567891",
                                    description: "I want a pet")
      application_2 = nova.applications.create!(name: "Adam Smith",
                                    address: "123 Fake Street",
                                    city: "Anywhere",
                                    state: "CA",
                                    zip: "12345",
                                    phone_number: "1234567891",
                                    description: "I want a pet")

      expect(Application.unique_pets).to eq([luna, nova])

      application_3 = nova.applications.create!(name: "Jane Smith",
                                    address: "123 New Street",
                                    city: "Anywhere",
                                    state: "CA",
                                    zip: "12345",
                                    phone_number: "1234567891",
                                    description: "I want a pet")

      expect(Application.unique_pets).to eq([luna, nova])
      end
    end
  end
