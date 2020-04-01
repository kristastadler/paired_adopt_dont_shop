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
    if favorites.contents.include?(pet.id.to_s)
      session[:favorites].delete(params[:pet_id])
      flash[:notice] = "#{pet.name} has been removed from your favorites list."
      redirect_back(fallback_location: "/")
    else
      favorites.add_pet(pet.id)
      session[:favorites] = favorites.contents
      flash[:notice] = "#{pet.name} has been added to your favorites list."
      redirect_back(fallback_location: "/")
    end
  end

  def destroy
    session[:favorites] = {}
    flash[:notice] = "You have no favorited pets."
    redirect_back(fallback_location: "/")
  end
end
