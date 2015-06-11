class CreateSkillUsers < ActiveRecord::Migration
  def change
    create_table :skill_users do |t|
    	t.integer :skill_id
    	t.integer :user_id
    	t.integer :level
    	t.integer :used_year

      t.timestamps null: false
    end
  end
end
