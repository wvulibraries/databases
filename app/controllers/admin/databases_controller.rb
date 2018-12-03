class Admin::DatabasesController < ApplicationController
  before_action :set_database, only: [:show, :edit, :update, :destroy]

  # GET /admin/databases
  # GET /admin/databases.json
  def index
    @databases = Database.all.order('name ASC')
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
        format.html { redirect_to @database, notice: 'Database was successfully created.' }
        format.json { render :show, status: :created, location: @database }
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
        format.html { redirect_to @database, notice: 'Database was successfully updated.' }
        format.json { render :show, status: :ok, location: @database }
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
      format.html { redirect_to databases_url, notice: 'Database was successfully destroyed.' }
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
