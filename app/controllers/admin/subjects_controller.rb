class Admin::SubjectsController < AdminController
  before_action :set_admin_subject, only: [:edit, :update, :destroy]

  # GET /admin/subjects
  # GET /admin/subjects.json
  def index
    @subjects = Subject.all.order(:name)
  end

  # GET /admin/subjects/1
  # GET /admin/subjects/1.json
  def show
    redirect_to admin_subjects_url
  end

  # GET /admin/subjects/new
  def new
    @subject = Subject.new
  end

  # GET /admin/subjects/1/edit
  def edit
  end

  # GET /admin/curated 
  def curated
    @curated = DatabaseCurated.includes(:database, :subject).all.order('subjects.name asc')
  end 

  # GET /admin/curated/:subject/sort 
  def sort
    subject_id = params[:subject]
    @curated = DatabaseCurated.includes(:database).where(subject_id: subject_id).order('sort desc')
  end 

  # POST /admin/curated
  def update_curated 
    begin 
    result = DatabaseCurated.update(curated_params.keys, curated_params.values)
    redirect_to admin_subjects_path, success: "Sort Order Updated"
    rescue 
      redirect_to '/admin/subjects', error: "Either sort enumeration is not correct or the ID can not be found." 
    end
  end 

  # POST /admin/subjects
  # POST /admin/subjects.json
  def create
    @subject = Subject.new(admin_subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to admin_subject_path(@subject), success: I18n.t('admin.basic.messages.created', model: 'subject') }
        format.json { render :show, status: :created, location: admin_subject_path(@subject) }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/subjects/1
  # PATCH/PUT /admin/subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(admin_subject_params)
        format.html { redirect_to admin_subject_path(@subject), success: I18n.t('admin.basic.messages.updated', model: 'subject') }
        format.json { render :show, status: :ok, location: admin_subject_path(@subject) }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/subjects/1
  # DELETE /admin/subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to admin_subjects_url, success: I18n.t('admin.basic.messages.deleted', model: 'subject') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_subject_params
      params.require(:subject).permit(:name, :url)
    end

    # sorting params to protect from evil interwebz 
    def curated_params
      curated = params.require(:curated).permit(:id => [], :database_name => [], :sort => [])
      param_hash = {}
      curated['id'].each_with_index do |val, i| 
        param_hash[val.to_i] = { "sort" => curated['sort'][i] }
      end
      return param_hash  
    end
end
