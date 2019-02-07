# Vendors Controller
class Admin::VendorsController < AdminController
  # filters
  before_action :set_admin_vendor, only: [:edit, :update, :destroy]

  # GET /admin/vendors
  # GET /admin/vendors.json
  def index
    @vendors = Vendor.all
  end

  # GET /admin/vendors/1
  # GET /admin/vendors/1.json
  def show
    @vendor = Vendor.includes(:databases).find(params[:id])
  end

  # GET /admin/vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /admin/vendors/1/edit
  def edit
  end

  # POST /admin/vendors
  # POST /admin/vendors.json
  def create
    @vendor = Vendor.new(admin_vendor_params)

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to admin_vendor_path(@vendor), success: I18n.t('admin.basic.messages.created', model: 'vendor') }
        format.json { render :show, status: :created, location: @vendor }
      else
        format.html { render :new }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/vendors/1
  # PATCH/PUT /admin/vendors/1.json
  def update
    respond_to do |format|
      if @vendor.update(admin_vendor_params)
        format.html { redirect_to admin_vendor_path(@vendor), success: I18n.t('admin.basic.messages.updated', model: 'vendor') }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/vendors/1
  # DELETE /admin/vendors/1.json
  def destroy
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to admin_vendors_url, success: I18n.t('admin.basic.messages.deleted', model: 'vendor') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_vendor_params
      params.require(:vendor).permit(:name, :url)
    end
end
