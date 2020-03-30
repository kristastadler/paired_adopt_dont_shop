class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:pet_id])
    if @pet.approved_application != nil
      @application = Application.find(@pet.approved_application)
    end
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    pet.destroy
    redirect_to "/pets"
  end

  private
    def pet_params
      params.permit(:image, :name, :description, :age, :sex, :status)
    end

end
