class SearchesController < ApplicationController

	def index
		@users = []

		params[:keywords].split('+').each do |keyword|
			@users += User.search(keyword)
		end

		if @users.empty?
			flash_msg(["No results found."], :warning)
		else
			@users = @users.uniq
		end

		render :results
	end

	def create
		keywords = params[:keywords].split(' ')
		redirect_to results_url(keywords.join('+'))
	end

end
