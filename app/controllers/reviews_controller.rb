class ReviewsController < ApplicationController
  
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end
  
  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created: Please fill in a title, rating, and content in order to submit a shelter review."
      render :new
    end
  end
  
  def edit
    @review = Review.find(params[:review_id])
  end 

  def update 
    review = Review.find(params[:review_id])
    review.update(review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter_id}"
    else
      redirect_to "/shelters/#{review.shelter_id}/reviews/#{review.id}/edit"
      flash[:notice] = "Review not created: Please fill in a title, rating, and/or content in order to edit a shelter review."
    end
  end
  
private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

end
