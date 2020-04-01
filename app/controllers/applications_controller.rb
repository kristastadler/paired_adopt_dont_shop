class ApplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents.keys)
  end

  def create
    params[:favorite_pets][:pet_ids].delete_if {|id| id.blank?}
    application = Application.new(application_params)
    if application.save
      pet_ids = params[:favorite_pets][:pet_ids]
      pet_ids.each do |favorite_pet_id|
        pet = ApplicationPet.create(application_id: application.id, pet_id: favorite_pet_id)
        session[:favorites].delete(favorite_pet_id)
      end
      flash[:notice] = "Application created successfully for all selected pets."
      redirect_to "/favorites"
    else
      flash[:notice] = "You must fill out all fields and/or check at least one box in order to submit this application."
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:application_id])
  end

  def update
    @application = Application.find(params[:application_id])
    @application.pets.each do |pet|
      pet.update(status: "Pending Adoption", approved_application: @application.id)
      pet.save
    end
  end

private

def application_params
  params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
end
end
