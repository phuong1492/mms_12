class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
    	t.text :description
    	t.string :name
    	t.integer :leader_id

      t.timestamps null: false
    end
  end
end
