class AddGamertagLowerToPlayers < ActiveRecord::Migration
  def up
  	change_table :players do |t|
  		t.string :gamertag_lower
  	end

  	Player.update_all ["gamertag_lower = lower(gamertag)"]
  end

  def down
  	remove_column :players, :gamertag_lower
  end
end
