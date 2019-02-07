class Public::BaseController < ApplicationController
  def index 
    @subjects = Subject.all.order('name ASC').group_by{|d| d.name[0]}
    @letters = Database.letters
    @trials = Database.trials.prod.includes(:landing_page)
    @popular = Database.pop_list.prod.includes(:landing_page)
    render :index
  end
  
  def a_to_z 
    @letters = Database.letters
    @character = params[:character].upcase
    if @character == "NUM"
      @databases = Database.number_list.prod.includes(:landing_page).order('name ASC')
    else 
      @databases = Database.alpha_list(@character).prod.includes(:landing_page).order('name ASC')
    end  
    render :list
  end 

  def all 
    @letters = Database.letters
    @databases = Database.grouped_alpha
    @count = Database.total_count
    render :list_all
  end

  def subject
    @subjects = Subject.all.order('name ASC').group_by{|d| d.name[0]}
    @letters = Database.letters
    render :subject
  end

  def subject_databases
    subject_id = params[:id]
    @curated = DatabaseCurated.includes(:database).where(subject_id: subject_id)
    curated_ids = @curated.pluck(:database_id)
    @databases = Database.list_subjects(subject_id).includes(:landing_page).where.not(id: curated_ids)
    @subject = Subject.find(subject_id)
    @count = @databases.count + @curated.count
    render :subject_db_list
  end
end
