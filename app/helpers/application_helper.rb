module ApplicationHelper
	def is_numeric?(obj) 
	   obj.to_s.match(/\A[+-]?\d+?\Z/) == nil ? false : true
	end
end
