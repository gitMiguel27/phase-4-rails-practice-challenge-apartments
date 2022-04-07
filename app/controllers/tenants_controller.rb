class TenantsController < ApplicationController

    def index
        render json: Tenant.all
    end

    def show
        tenant = find_tenant
        render json: tenant
    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: "tenant not found" }, status: :not_found
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: "tenant not found" }, status: :not_found
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find(params[:id])
    end
end
