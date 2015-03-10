class CertificatesController < ApplicationController
  before_action :set_certificate, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => :index

  # GET /certificates
  # GET /certificates.json
  def index
    @certificates = Certificate.all
  end

  # GET /certificates/1
  # GET /certificates/1.json
  def show
    authorize @certificate
  end

  # GET /certificates/new
  def new
    @certificate = Certificate.new
    authorize @certificate
  end

  # GET /certificates/1/edit
  def edit
    authorize @certificate
  end

  # POST /certificates
  # POST /certificates.json
  def create
    @certificate = Certificate.new(certificate_params)
    authorize @certificate

    respond_to do |format|
      if @certificate.save
        format.html { redirect_to @certificate, notice: t('saved') }
        format.json { render action: 'show', status: :created,
                      location: @certificate }
      else
        format.html { render action: 'new' }
        format.json { render json: @certificate.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certificates/1
  # PATCH/PUT /certificates/1.json
  def update
    authorize @certificate
    respond_to do |format|
      if @certificate.update(certificate_params)
        format.html { redirect_to certificates_path, notice: t('updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certificates/1
  # DELETE /certificates/1.json
  def destroy
    authorize @certificate
    @certificate.destroy
    respond_to do |format|
      format.html { redirect_to certificates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    def certificate_params
      params.require(:certificate).permit(:title)
    end
end
