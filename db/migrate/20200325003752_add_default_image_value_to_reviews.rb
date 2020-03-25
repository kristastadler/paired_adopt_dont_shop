class AddDefaultImageValueToReviews < ActiveRecord::Migration[5.1]
  def change
    change_column_default :reviews, :image, "No image added"
  end
end
