class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :new, :create, :show,
                                  :edit, :update, :destroy]

  # GET /kids
  # GET /kids.json
  def index
    @kids = Kid.all
  end

  # GET /kids/1
  # GET /kids/1.json
  def show
  end

  # GET /kids/new
  def new
    @kid = Kid.new
  end

  # GET /kids/1/edit
  def edit
  end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(kid_params)
    @kid.user = @user

    respond_to do |format|
      if @kid.save
        format.html { redirect_to user_kids_path(@user), notice: 'Barnet er lagret' }
        format.json { render action: 'show', status: :created, location: @kid }
      else
        format.html { render action: 'new' }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kids/1
  # PATCH/PUT /kids/1.json
  def update
    respond_to do |format|
      if @kid.update(kid_params)
        format.html { redirect_to user_kids_path(@user), notice: t(:saved) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid.destroy
    respond_to do |format|
      format.html { redirect_to user_kids_path(@user), notice: 'Slettet' }
      format.json { head :no_content }
    end
  end

  private
    def set_kid
      @kid = Kid.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def kid_params
      params.require(:kid).permit(:references, :name, :birth_date, :sole_custody)
    end
end
