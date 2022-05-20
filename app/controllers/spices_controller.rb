class SpicesController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :spice_not_found

    # GET /spices: return an array of all spices
    def index
        render json: Spice.all
    end

    # POST /spices: create a new spice
    def create
        render json: Spice.create(new_spice_params), status: :created
    end

    # PATCH /spices/:id
    def update
        spice = find_single_spice
        spice.update(new_spice_params)
        render json: spice
    end

    #delete
    def destroy
        spice = find_single_spice
        spice.destroy
        render json: {}
    end
    private

    #use of strong params
    def new_spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_single_spice
        Spice.find(params[:id])
    end

    def spice_not_found
        render json: {error: "Spice with id #{params[:id]}, not found"}, status: :not_found
    end

end
