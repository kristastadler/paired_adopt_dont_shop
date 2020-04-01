class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])
    if pet.status == "Adoptable"
      pet.update(status: "Pending Adoption", approved_application: application.id)
      pet.save
      redirect_to "/pets/#{pet.id}"
    else
      pet.update(status: "Adoptable", approved_application: nil)
      pet.save
      redirect_to "/applications/#{application.id}"
    end
  end
end
