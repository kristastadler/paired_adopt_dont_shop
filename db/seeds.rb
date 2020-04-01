# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
Review.destroy_all
Application.destroy_all

shelter_1 = Shelter.create(name: "Jordan's Shelter",
                           address: "123 Fake St.",
                           city: "Arvada",
                           state: "CO",
                           zip: 80003)

shelter_2 = Shelter.create(name: "Krista's Shelter",
                           address: "321 Real Rd.",
                           city: "Denver",
                           state: "CO",
                           zip: 80301)

shelter_3 = Shelter.create(name: "Meg's Shelter",
                           address: "311 Realfake Ave.",
                           city: "Arvada",
                           state: "CO",
                           zip: 80003)

luna = Pet.create(name: "Luna",
                  age: "5",
                  sex: "Female",
                  status: "Adoptable",
                  image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
                  description: "Very good dog.",
                  shelter: shelter_1)

nova = Pet.create(name: "Nova",
                  age: "10",
                  sex: "Female",
                  status: "Adoptable",
                  image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                  description: "Amazingly good dog.",
                  shelter: shelter_1)
                  
rhombus = Pet.create(name: "Rhombus",
                     age: "2",
                     sex: "Male",
                     status: "Adoptable",
                     image: "http://cdn.akc.org/content/article-body-image/keeshond_dog_pictures_2.jpg",
                     description: "Extremely good dog.",
                     shelter: shelter_2)

roomba = Pet.create(name: "Roomba",
                    age: "7",
                    sex: "Male",
                    status: "Adoptable",
                    image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                    description: "Hilariously good dog.",
                    shelter: shelter_2)

triangle = Pet.create(name: "Triangle",
                      age: "3",
                      sex: "Male",
                      status: "Adoptable",
                      image: "http://cdn.akc.org/content/article-body-image/newfoundland_dog_pictures.jpg",
                      description: "Acute dog!",
                      shelter: shelter_3)

review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                    rating: 5,
                                    content: "Staff were so helpful and the process was easy.")

review_2 = shelter_1.reviews.create(title: "Good experience",
                                    rating: 4,
                                    content: "Happy with this animal shelter",
                                    image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")                    

review_3 = shelter_2.reviews.create(title: "Love this place!",
                                    rating: 5,
                                    content: "This is my favorite dog shelter!",
                                    image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")                    

application_1 = Application.create(name: "Hilary Sewell",
                                       address: "101 1st St",
                                       city: "Arvada",
                                       state: "CO",
                                       zip: "80003",
                                       phone_number: "3175186802",
                                       description: "I would be a great owner because I make those developer dollar$!")
      
luna = ApplicationPet.create(application_id: application_1.id, pet_id: luna.id)
nova = ApplicationPet.create(application_id: application_1.id, pet_id: nova.id)