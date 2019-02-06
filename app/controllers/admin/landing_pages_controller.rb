class Admin::LandingPagesController < AdminController
  before_action :set_admin_landing_page, only: [:show, :edit, :update, :destroy]

  # GET /admin/landing_pages
  # GET /admin/landing_pages.json
  def index
    @landing_pages = LandingPage.all.includes(:database)
  end

  # GET /admin/landing_pages/1
  # GET /admin/landing_pages/1.json
  def show
  end

  # GET /admin/landing_pages/new
  def new
    @landing_page = LandingPage.new
  end

  # GET /admin/landing_pages/1/edit
  def edit
  end

  # POST /admin/landing_pages
  # POST /admin/landing_pages.json
  def create
    @landing_page = LandingPage.new(admin_landing_page_params)

    respond_to do |format|
      if @landing_page.save
        format.html { redirect_to admin_landing_page_path(@landing_page), notice: 'Landing page was successfully created.' }
        format.json { render :show, status: :created, location: @landing_page }
      else
        format.html { render :new }
        format.json { render json: @landing_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/landing_pages/1
  # PATCH/PUT /admin/landing_pages/1.json
  def update
    respond_to do |format|
      if @landing_page.update(admin_landing_page_params)
        format.html { redirect_to admin_landing_page_path(@landing_page), notice: 'Landing page was successfully updated.' }
        format.json { render :show, status: :ok, location: @landing_page }
      else
        format.html { render :edit }
        format.json { render json: @landing_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/landing_pages/1
  # DELETE /admin/landing_pages/1.json
  def destroy
    @landing_page.destroy
    respond_to do |format|
      format.html { redirect_to admin_landing_pages_url, notice: 'Landing page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_landing_page
      @landing_page = LandingPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_landing_page_params
      params.fetch(:landing_page, {})
      params.require(:landing_page).permit(:contact_name, :contact_email, :contact_phone_number, :contact_title, :instructions, :restrictions, :html_links, :database_id)
    end
end
