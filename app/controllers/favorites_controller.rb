class FavoritesController < ApplicationController

  def index
  end

  def update
    pet = Pet.find(params[:pet_id])
    flash[:notice] = "#{pet.name} has been added to your favorites list."
    redirect_to "/pets/#{pet.id}"
  end

end
