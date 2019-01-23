class Admin::DatabasesController < AdminController
  # filters
  before_action :set_database, only: [:show, :edit, :update, :destroy]

  # GET /admin/databases
  # GET /admin/databases.json
  # GET /admin/databases.csv 
  def index
    @databases = Database.all
    respond_to do |format|
      format.html do 
        @databases = @databases.includes(:vendor).order('name ASC')
        render :table 
      end 
      format.csv do
        @databases = @databases.includes(
          :database_subjects,
          :resources, 
          :subjects, :vendor, 
          :access_plain_text, 
          :access_type)
        .order('name ASC')
        send_data @databases.to_csv, filename: "databases-#{Date.today}.csv" 
      end 
    end         
  end

  # GET /admin/databases/list/:status
  def listall
    @databases =  Database.all
                          .includes(
                            :database_subjects, 
                            :subjects, :vendor, 
                            :access_plain_text, 
                            :access_type )
                          .order('name ASC')
    render :list
  end 


  # GET /admin/databases/list/:status
  def list
    @databases =  Database.with_status(params[:status])
                          .includes(
                            :database_subjects, 
                            :subjects, :vendor, 
                            :access_plain_text, 
                            :access_type )
                          .order('name ASC')
    render :list
  end 

  # GET /admin/databases/tables/:status
  def tables 
    if params[:status].present?
      @databases =  Database.with_status(params[:status])
                            .includes(:vendor)
                            .order('name ASC')
    else
      @databases = Database.all
                            .includes(:vendor)
                            .order('name ASC')
    end  
    render :table
  end 
  
  # GET /admin/databases/1
  # GET /admin/databases/1.json
  def show
  end

  # GET /admin/databases/new
  def new
    @database = Database.new
  end

  # GET /admin/databases/1/edit
  def edit
  end

  # POST /admin/databases
  # POST /admin/databases.json
  def create
    @database = Database.new(database_params)

    respond_to do |format|
      if @database.save
        format.html { redirect_to admin_database_path(@database), success: I18n.t('admin.databases.controllers.new') }
        format.json { render :show, status: :created, location: admin_database_path(@database) }
      else
        format.html { render :new }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/databases/1
  # PATCH/PUT /admin/databases/1.json
  def update
    respond_to do |format|
      if @database.update(database_params)
        format.html { redirect_to admin_database_path(@database.id), success: I18n.t('admin.databases.controllers.update') }
        format.json { render :show, status: :ok, location: admin_database_path(@database) }
      else
        format.html { render :edit }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/databases/1
  # DELETE /admin/databases/1.json
  def destroy
    @database.destroy
    respond_to do |format|
      format.html { redirect_to admin_databases_url, success: I18n.t('admin.databases.controllers.delete') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_database
      @database = Database.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def database_params
      params.require(:database).permit(:name, :status, :years_of_coverage, :url, :off_campus_url, :updated, :full_text_db, :new_database, :trial_database, :help, :help_url, :description, :created_date, :updated_date, :popular, :trial_expire_date, :alumni, :title_search)
    end
end
