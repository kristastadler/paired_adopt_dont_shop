class PetApplicationsController < ApplicationController

def show
  @pet = Pet.find(params[:pet_id])
end

def update
  pet = Pet.find(params[:pet_id])
  application = Application.find(params[:application_id])
  pet.update(status: "Pending Adoption", approved_application: application.id)
  pet.save
  redirect_to "/pets/#{pet.id}"
end

end
