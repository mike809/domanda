class SearchesController < ApplicationController
	
	def create
		@users = User.search(params[:keywords])
		render :results
	end

end
