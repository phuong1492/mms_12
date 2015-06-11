class CreatePositionUsers < ActiveRecord::Migration
  def change
    create_table :position_users do |t|
    	t.integer :user_id
    	t.integer :position_id

      t.timestamps null: false
    end
  end
end
