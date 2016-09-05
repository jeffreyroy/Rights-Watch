class CreateOpinions < ActiveRecord::Migration
  def change
  	 create_table :opinions do |t|
  		t.string :opinion_type, default: "majority"
  		t.integer :case_id
  		t.integer :justice_id

  	end
  end
end
