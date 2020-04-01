class FavoritesController < ApplicationController

  def index
    @pets = Pet.all
    @unique_pets = Application.unique_pets
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
