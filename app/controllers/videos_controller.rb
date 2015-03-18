class VideosController < ApplicationController
	def index
		@video =Video.all
	end
end