class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.string :name
    	t.string :abbreviation
    	t.datetime :startdate
    	t.datetime :enddate
    	t.integer :leader_id

      t.timestamps null: false
    end
  end
end
