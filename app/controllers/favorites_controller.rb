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


def update
    song = Song.find(params[:song_id])
    @cart = Cart.new(session[:cart])
    @cart.add_song(song.id)
    session[:cart] = @cart.contents
    quantity = @cart.count_of(song.id)
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{song.title} in your cart."
    redirect_to songs_path
  end
#if / else statement to only increment if value of hash is 0.
