module ApplicationHelper
	
	# fix title = Training when common_title is empty
	def fix_title(common_title)
		base_title = "Training"
		if common_title.empty?
			base_title 	
		else
			common_title
		end
	end
end
