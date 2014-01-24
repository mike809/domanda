class SearchesController < ApplicationController

	def index
		@results = []

		params[:keywords].split('+').each do |keyword|
			@results += User.search(keyword)
		end

		params[:keywords].split('+').each do |keyword|
			@results += Question.search(keyword)
		end

		if @results.empty?
			flash_msg(["No results found."], :warning)
		else
			@results = @results.sort_by{ |result| @results.count(result)}.uniq
		end

		render :results
	end

	def create
		keywords = params[:keywords].split(' ')
		redirect_to results_url(keywords.join('+'))
	end

end
