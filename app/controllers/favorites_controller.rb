class FavoritesController < ApplicationController

  def index
    @pets = Pet.all
    applications = Application.all
    @unique_pets = []
    applications.each do |application|
      application.pets.each do |pet|
          @unique_pets << pet
      end
    end
    @unique_pets = @unique_pets.uniq
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} has been added to your favorites list."
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorites].delete(params[:pet_id])
    flash[:notice] = "#{pet.name} has been removed from your favorites list."
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    session[:favorites] = {}
    flash[:notice] = "You have no favorited pets."
    redirect_back(fallback_location: root_path)
  end
end
