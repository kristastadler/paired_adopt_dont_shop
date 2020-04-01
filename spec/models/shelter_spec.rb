require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_length_of(:zip).is_equal_to(5)}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe "instance methods" do
    it "#count_approved_applications" do
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
    end

    it "#avg_review" do 
      shelter_1 = Shelter.create(name: "Jordan's Shelter",
                                 address: "123 Fake St.",
                                 city: "Arvada",
                                 state: "CO",
                                 zip: 80003)

      review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                    rating: 5,
                                    content: "Staff were so helpful and the process was easy.")

      review_2 = shelter_1.reviews.create(title: "Good experience",
                                          rating: 4,
                                          content: "Happy with this animal shelter",
                                          image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")                    

      review_3 = shelter_1.reviews.create(title: "The experience was average.",
                                          rating: 3,
                                          content: "I did not find a dog.")

      expect(shelter_1.avg_review).to eq(4)
    end

    it "#app_count" do 
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

      triangle = Pet.create(name: "Triangle",
                          age: "5",
                          sex: "Male",
                          status: "Adoptable",
                          image: "https://cdn.shopify.com/s/files/1/1257/5497/products/ondogs-30_1080x.jpg?v=1574393629",
                          description: "Acute dog!",
                          shelter: shelter_1)

      
      application_1 = Application.create(name: "name",
                                         address: "address",
                                         city: "city",
                                         state: "state",
                                         zip: "zip",
                                         phone_number: "phone_number",
                                         description: "description")
                                      
      application_2 = Application.create(name: "name",
                                         address: "address",
                                         city: "city",
                                         state: "state",
                                         zip: "zip",
                                         phone_number: "phone_number",
                                         description: "description")
      
      application_3 = Application.create(name: "name",
                                         address: "address",
                                         city: "city",
                                         state: "state",
                                         zip: "zip",
                                         phone_number: "phone_number",
                                         description: "description")
      
      ApplicationPet.create(application_id: application_1.id, pet_id: luna.id)
      expect(shelter_1.app_count).to eq(1)
      
      ApplicationPet.create(application_id: application_2.id, pet_id: nova.id)
      expect(shelter_1.app_count).to eq(2)

      ApplicationPet.create(application_id: application_3.id, pet_id: triangle.id)
      expect(shelter_1.app_count).to eq(3)
    end
  end
end
