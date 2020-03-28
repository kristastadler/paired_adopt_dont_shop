class ApplicationsController < ApplicationController

  def new
    @pets = Pet.all
  end

  def create
    application = Application.create!(application_params)
      require "pry"; binding.pry
    pet = ApplicationPets.create!(application_id: application.id,


  end


private

def application_params
  params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
end
end



# <% @pets.each do |pet| %>
#   <% if favorites.contents.has_key?(pet.id.to_s) %>
#     <%= pet.name %><%= check_box_tag pet.name %></br>
#   <% end %>
# <% end %>
