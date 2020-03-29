class ApplicationsController < ApplicationController

  def new
    @pets = []
    Pet.all.each do |pet|
      if favorites.contents.has_key?(pet.id.to_s)
        @pets << pet
      end
    end
    @pets
  end

  def create
    application = Application.create!(application_params)
    params[:favorite_pets][:pet_ids].each do |favorite_pet_id|
    pet = ApplicationPet.create(application_id: application.id,
                                pet_id: favorite_pet_id)
      end
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:application_id])
  end


private

def application_params
  params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
end
end
