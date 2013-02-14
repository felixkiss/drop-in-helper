class Player < ActiveRecord::Base
  attr_accessible :gamertag, :rating

 	before_save :strip_whitespace_from_gamertag
  before_save :update_gamertag_lower

private

	def strip_whitespace_from_gamertag
		self.gamertag.strip!
	end

	def update_gamertag_lower
		self.gamertag_lower = self.gamertag.downcase
	end

end
