class ApartmentsController < ApplicationController

    def index
        render json: Apartment.all
    end

    def show
        apartment = find_apartment
        render json: apartment
    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: "tenant not found" }, status: :not_found
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: "tenant not found" }, status: :not_found
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end
end
