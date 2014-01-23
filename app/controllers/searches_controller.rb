class SearchesController < ApplicationController

	def index
		@users = User.search(*params[:keywords].split('+'))

		if @users.empty?
			flash_msg(["No results found."], :warning)
		end

		render :results
	end

	def create
		keywords = params[:keywords].split(' ')
		redirect_to results_url(keywords.join('+'))
	end

end
