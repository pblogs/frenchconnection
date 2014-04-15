class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
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
  end

  def excel_report
    @customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    require 'spreadsheet'

    #format
    #
    #yellow_bg = Spreadsheet::Format.new :color => :yellow
    yellow_bg = Spreadsheet::Format.new(:pattern => 1, 
                                        :pattern_fg_color => :yellow)
    
    gray_bg = Spreadsheet::Format.new(:pattern => 1, color: :black,
                                      :pattern_fg_color => :gray)

    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = "Dagsrapport #{@customer.name}"
    sheet.row(0) << nil 
    sheet.row(1).concat %W{LOGO Dagsrapport}

    sheet.row(2).concat ['År: ', '', 'Pågår']
    sheet.row(3).concat ['Uke: ', '', 'Utført']
    sheet.row(4).concat ['Prosjekt nr: ', '']
    sheet.row(5).concat ['Kunde: ', '', ]
    4.times { |x| sheet.row(x+2).set_format(1, yellow_bg ) }

    # 5 blanks with C D E F G spanning from 7-11
    sheet.merge_cells(6, 2, 11, 2) # Col C
    sheet.merge_cells(6, 3, 11, 3) # Col D
    sheet.merge_cells(6, 4, 11, 4) # Col E
    sheet.merge_cells(6, 5, 11, 5) # Col F

    # Make the C column wide
    sheet.column(1).width = 50

    # Gray row with Dato:
    sheet.row(11).concat ['Dato: ', '' ]
    sheet.row(11).set_format(0, gray_bg )
    sheet.row(11).set_format(1, gray_bg )

    # Her kommer rapporten
    #@customer.tasks.each do |t|
    #  sheet.row(12).concat [t.created_at, "#{}" ]

    #sheet.row(0).concat %w{Name Country Acknowlegement}
    #sheet[1,0] = 'Japan'
    #row = sheet.row(1)
    #row.push 'Creator of Ruby'
    #row.unshift 'Yukihiro Matsumoto'
    #sheet.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
    #                        'Author of original code for Spreadsheet::Excel' ]
    #sheet.row(3).push 'Charles Lowe', 'Author of the ruby-ole Library'
    #sheet.row(3).insert 1, 'Unknown'
    #sheet.update_row 4, 'Hannes Wyss', 'Switzerland', 'Author'
    
    spreadsheet = StringIO.new 
    book.write spreadsheet 
    send_data spreadsheet.string, 
      :filename => "dagsrapport-#{@customer.name}.xls", 
      :type => "application/vnd.ms-excel"
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :address, :org_number, :contact_person, :phone)
    end
end
