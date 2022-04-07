class LeasesController < ApplicationController

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: "tenant not found" }, status: :not_found
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
