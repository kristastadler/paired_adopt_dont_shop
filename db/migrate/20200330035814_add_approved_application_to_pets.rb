class AddApprovedApplicationToPets < ActiveRecord::Migration[5.1]
  def change
      add_column :pets, :approved_application, :string
    end
  end
