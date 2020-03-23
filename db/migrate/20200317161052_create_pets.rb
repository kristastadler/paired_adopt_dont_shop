class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :sex
      t.string :status, :default => "Adoptable"
      t.string :image
    end
  end
end
