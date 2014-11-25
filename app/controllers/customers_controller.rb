class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_project_leader

  # GET /customers
  # GET /customers.json
  def index
    @search    = Customer.search(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @customers = @search.result
    paginate_customers(@customers)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    @is_favorite = @customer.is_favorite_of?(@current_user)
  end

  def search
    @customers = Customer.where("name ILIKE ?", "%#{params[:query]}%").all
    @search    = Customer.search(params[:q])
    paginate_customers(@customers, params[:query])
    render :index
  end

  
  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        set_favorite
        format.html { redirect_to @customer,
                      notice: 'Customer was successfully created.' }
        format.json { render action: 'show', 
                      status: :created, location: @customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        set_favorite
        format.html { redirect_to @customer,
                      notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, 
    # only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :address, :org_number,
                                       :contact_person, :phone)
    end

    def set_favorite
      if params[:starred]
        @current_user.favorites << @customer.set_as_favorite
      else
        @customer.unset_favorite(@current_user)
      end
    end

    def redirect_if_not_project_leader
      redirect_to root_url, 
        notice: 'Only for admin' unless @current_user.roles.first.match /project_leader/
    end

    def paginate_customers(customers, query = '')
      return if customers.empty?
      alpha_paginate_options = {
          :support_language => :en,
          :pagination_class => 'pagination-centered',
          :js => false,
          :include_all => false,
          :query => query,
          :default_field => get_paginate_default_field(
                                customers.order(:name).first.name[0])
      }
      @customers, @alpha_params = customers.alpha_paginate(
                                    params[:letter],
                                    alpha_paginate_options) { |c| c.name }
    end
end
