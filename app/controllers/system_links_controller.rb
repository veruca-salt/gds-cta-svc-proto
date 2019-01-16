class SystemLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_system_link, only: [:show, :edit, :update, :destroy]


  # GET /system_links
  # GET /system_links.json
  def index
    @system_links = SystemLink.all
  end

  # GET /system_links/1
  # GET /system_links/1.json
  def show
  end

  # GET /system_links/new
  def new
    @system_link = SystemLink.new
  end

  # GET /system_links/1/edit
  def edit
  end

  # POST /system_links
  # POST /system_links.json
  def create
    @system_link = SystemLink.new(system_link_params)

    respond_to do |format|
      if @system_link.save
        format.html { redirect_to @system_link, notice: 'System link was successfully created.' }
        format.json { render :show, status: :created, location: @system_link }
      else
        format.html { render :new }
        format.json { render json: @system_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_links/1
  # PATCH/PUT /system_links/1.json
  def update
    respond_to do |format|
      if @system_link.update(system_link_params)
        format.html { redirect_to @system_link, notice: 'System link was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_link }
      else
        format.html { render :edit }
        format.json { render json: @system_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_links/1
  # DELETE /system_links/1.json
  def destroy
    @system_link.destroy
    respond_to do |format|
      format.html { redirect_to system_links_url, notice: 'System link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_link
      @system_link = SystemLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_link_params
      params.require(:system_link).permit(:system_a_id, :system_b_id, :protocol, :weight)
    end

    def authenticate_user!
   redirect_to :login if current_user.nil?
  end
end
