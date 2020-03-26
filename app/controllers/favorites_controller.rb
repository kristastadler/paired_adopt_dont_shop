class FavoritesController < ApplicationController

  def index
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} has been added to your favorites list."
    redirect_to "/pets/#{pet.id}"
  end
end
