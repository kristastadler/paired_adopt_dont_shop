# Adopt Don't Shop Paired Project

The Adopt Don't Shop project is an interactive pet shelter website that allows a user to:
* create, view, edit, and delete pets,
* create, view, edit, and delete pet adoption shelters,
* create, view, edit, and delete user reviews for pet adoption shelters,
* favorite and unfavorite pets,
* create adoption applications and, ultimately, adopt pets.

## How to Clone Project to Local Machine
Use the instructions below in combination with your terminal in order to learn more about this project:

  1. Clone this repository:
    ```git clone git@github.com:jrsewell400/adopt_dont_shop_paired.git```
    
  1. Install the necessary gems:
    ```bundle install``` &
    ```bundle update```

  1. Initialize the database:
    ```rails db:{create,migrate,seed}```
  
  1. Make a connection with the Rails server:
    ```rails s```
    
  1. Visit your browser, and enter the following into the search bar: 
  ```localhost:3000```
  
  1. Enjoy!

## Schema Design
Below is a diagram of this project's schema, which was built using PostgreSQL:
<img width="1003" alt="Screen Shot 2020-04-01 at 1 15 57 PM" src="https://user-images.githubusercontent.com/54481094/78177289-2318fa80-741b-11ea-9b15-43e1e4181cda.png">

## Skills Gained from this Project

### Rails
* Implement CRUD functionality for a resource using forms (form_tag), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Create routes for
  - standalone resources
  - nested resources
* Template a view in Rails using a templating language (ie, `erb`)
* Implement CRUD functionality for nested resources

### ActiveRecord
* Create instance methods and class methods on a Rails model that use ActiveRecord associations
* Use built-in ActiveRecord methods to:
  * create, read, update, and destroy records in a database
  * create records with relationships to other records in a database

### Databases
* Describe Database Relationships, including the following terms:
  - Primary Key
  - Foreign Key
  - One to Many
  - Many to Many
  - Joins Tables
  - Write migrations to create tables and relationships between tables
  - Describe ORMs and their advantages and use cases

### Testing and Debugging
* Write feature tests utilizing:
  - RSpec and Capybara
  - CSS selectors to target specific areas of a page
  - Use Pry or Byebug in Rails files to get more information about an error
  - Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
  - Utilize the Rails console as a tool to get more information about the current state of a development database
  - Use `rails routes` to get additional information about the routes that exist in a Rails application

## Link to Application in Production
* https://secure-cliffs-48267.herokuapp.com/

## Links to Contributor Github Profiles
* Krista Sadler:  https://github.com/kristastadler
* Jordan Sewell:  https://github.com/jrsewell400