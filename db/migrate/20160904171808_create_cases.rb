class CreateCases < ActiveRecord::Migration
  def change
  	 create_table :cases do |t|
  		t.string :name,  { null: false }
  		t.date :date_decided,  { null: false }
  		t.string :cite1
  		t.string :cite2
  		t.integer :issue_id

  	end
  end
end
