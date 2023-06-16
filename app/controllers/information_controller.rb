class InformationController < ApplicationController
    def show
    information = Information.all
    end

    def index
    information = Information.all 
    render json: information, include: [:animal, :sighting]
    end
end
