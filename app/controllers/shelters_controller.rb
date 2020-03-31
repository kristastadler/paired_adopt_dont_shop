class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      flash[:notice] = shelter.errors.full_messages.to_sentence
      redirect_to '/shelters/new'
    end

  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
  end

  def update
    shelter = Shelter.find(params[:shelter_id])
    shelter.update(shelter_params)
    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = shelter.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    Shelter.destroy(params[:shelter_id])
    redirect_to "/shelters"
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
