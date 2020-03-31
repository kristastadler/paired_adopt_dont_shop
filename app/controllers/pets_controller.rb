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
    if pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
    else 
      flash[:notice] = pet.errors.full_messages.to_sentence
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    if pet.approved_application == nil
      session[:favorites].delete(params[:pet_id]) if session[:favorites] != nil
      pet.destroy
      redirect_to "/pets"
    else 
      flash[:notice] = "Cannot delete a pet with an active adoption application!"
      redirect_to "/pets"
    end
  end

  private
    def pet_params
      params.permit(:image, :name, :description, :age, :sex, :status)
    end

end
