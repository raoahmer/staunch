require 'net/http'
require 'net/https'

class EmployeesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    page = params[:page]
    @employees = EmployeeApiService.list_employees(page: page)
  end

  def show
    @employee = EmployeeApiService.fetch_employee(params[:id])
  end

  def edit
    @employee = EmployeeApiService.fetch_employee(params[:id])
  end

  def create
    @employee = EmployeeApiService.create_employee(employee_params)
    redirect_to employee_path(@employee["id"])
  end

  def update
    @employee = EmployeeApiService.update_employee(params[:id], employee_params)
    redirect_to edit_employee_path(@employee["id"])
  end

  private

  def employee_params
    params.permit(:name, :position, :date_of_birth, :salary)
  end 
end
