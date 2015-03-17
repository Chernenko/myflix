class CategoriesController < ApplicationController
	def index
		@category = category.all
	end
end
