# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all

shelter_1 = Shelter.create(name: "Jordan's Shelter",
                           address: "123 Fake St.",
                           city: "Arvada",
                           state: "CO",
                           zip: 80003)

shelter_2 = Shelter.create(name: "Hilary's Shelter",
                           address: "321 Real Rd.",
                           city: "Denver",
                           state: "CO",
                           zip: 80301)

shelter_3 = Shelter.create(name: "Hiljo's Shelter",
                           address: "311 Realfake Ave.",
                           city: "Arvada",
                           state: "CO",
                           zip: 80003)

luna = Pet.create(name: "Luna",
                  age: "5",
                  sex: "Female",
                  status: "Pending Adoption",
                  image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg",
                  description: "Very good dog.",
                  shelter: shelter_1)

rhombus = Pet.create(name: "Rhombus",
                     age: "2",
                     sex: "Male",
                     status: "Adoptable",
                     image: "http://cdn.akc.org/content/article-body-image/keeshond_dog_pictures_2.jpg",
                     description: "Extremely good dog.",
                     shelter: shelter_2)

nova = Pet.create(name: "Nova",
                  age: "10",
                  sex: "Female",
                  status: "Pending Adoption",
                  image: "http://cdn.akc.org/content/article-body-image/border_collie_dog_pictures_.jpg",
                  description: "Amazingly good dog.",
                  shelter: shelter_1)

roomba = Pet.create(name: "Roomba",
                    age: "7",
                    sex: "Male",
                    status: "Adoptable",
                    image: "http://cdn.akc.org/content/article-body-image/basset_hound_dog_pictures_.jpg",
                    description: "Hilariously good dog.",
                    shelter: shelter_2)
review_1 = shelter_1.reviews.create(title: "Found my new best friend!",
                                    rating: 5,
                                    content: "Staff were so helpful and the process was easy.")
review_2 = shelter_1.reviews.create(title: "Good experience",
                                    rating: 4,
                                    content: "Happy with this animal shelter",
                                    image: "http://cdn.akc.org/content/article-body-image/norwegianelkhoundpuppy_dog_pictures.jpg")                    
