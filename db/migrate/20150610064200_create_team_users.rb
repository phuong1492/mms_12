class CreateTeamUsers < ActiveRecord::Migration
  def change
    create_table :team_users do |t|

      t.timestamps null: false
    end
  end
end
