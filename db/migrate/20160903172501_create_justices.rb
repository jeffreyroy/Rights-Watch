class CreateJustices < ActiveRecord::Migration
  def change
  	create_table :justices do |t|
  		t.string :first_name,  { null: false }
  		t.string :last_name,  { null: false }
  		t.string :image_file

  	end
  end
end
