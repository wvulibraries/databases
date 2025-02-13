# Resources Controller
class Admin::ResourcesController < AdminController
  before_action :set_admin_resource, only: [:show, :edit, :update, :destroy]

  # GET /admin/resources
  # GET /admin/resources.json
  def index
    @resources = Resource.all
  end

  # GET /admin/resources/1
  # GET /admin/resources/1.json
  def show
  end

  # GET /admin/resources/new
  def new
    @resource = Resource.new
  end

  # GET /admin/resources/1/edit
  def edit
  end

  # POST /admin/resources
  # POST /admin/resources.json
  def create
    @resource = Resource.new(admin_resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to admin_resource_path(@resource), success: I18n.t('admin.basic.messages.created', model: 'Resource') }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/resources/1
  # PATCH/PUT /admin/resources/1.json
  def update
    respond_to do |format|
      if @resource.update(admin_resource_params)
        format.html { redirect_to admin_resource_path(@resource), success: I18n.t('admin.basic.messages.updated', model: 'Resource') }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/resources/1
  # DELETE /admin/resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_resources_url, success: I18n.t('admin.basic.messages.deleted', model: 'resource') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_resource_params
      params.require(:resource).permit(:name)
    end
end
