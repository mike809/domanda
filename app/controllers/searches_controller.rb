class SearchesController < ApplicationController

	def create
		@users = User.search(params[:keywords])

		unless @users.size > 0 
			flash_msg(["No results found."], :warning)
		end
		render :results
	end

end
