class TestmodelsController < ApplicationController
  before_action :set_testmodel, only: [:show, :edit, :update, :destroy]

  # GET /testmodels
  def index
    @testmodels = Testmodel.all
  end

  # GET /testmodels/1
  def show
  end

  # GET /testmodels/new
  def new
    @testmodel = Testmodel.new
  end

  # GET /testmodels/1/edit
  def edit
  end

  # POST /testmodels
  def create
    @testmodel = Testmodel.new(testmodel_params)

    if @testmodel.save
      redirect_to @testmodel, notice: 'Testmodel was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /testmodels/1
  def update
    if @testmodel.update(testmodel_params)
      redirect_to @testmodel, notice: 'Testmodel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /testmodels/1
  def destroy
    @testmodel.destroy
    redirect_to testmodels_url, notice: 'Testmodel was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testmodel
      @testmodel = Testmodel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def testmodel_params
      params.require(:testmodel).permit(:teststring, :testcheck, :testnumber)
    end
end
