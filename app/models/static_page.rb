class StaticPage < ApplicationRecord
	def  hello
		render html: hello
	end 
end
