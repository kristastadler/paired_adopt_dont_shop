require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe "#approved_applications?" do
    it "returns a boolean value of whether or not any pets in the shelter have an approved application" do
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
      application = Application.create(name: "name",
                                       address: "address",
                                       city: "city",
                                       state: "state",
                                       zip: "zip",
                                       phone_number: "phone_number",
                                       description: "description")
      luna = ApplicationPet.create(application_id: application.id, pet_id: luna.id)
      nova = ApplicationPet.create(application_id: application.id, pet_id: nova.id)

      expect(shelter_1.count_approved_applications).to eq(0)

      # luna = Pet.update(name: "Luna",
      #                   age: "5",
      #                   sex: "Female",
      #                   status: "Adoptable",
      #                   image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
      #                   shelter: shelter_1,
      #                   approved_application: application.id
      #                   )
      # expect(shelter_1.count_approved_applications).to eq(1)
    end
  end
end
