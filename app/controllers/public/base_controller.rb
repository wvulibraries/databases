# Public::BaseController 
# Controller that deals with the public facing interfaces. 
class Public::BaseController < ApplicationController
  # Root controller of public inteface.
  # Sets the subjects, letters, trial databases, and public databases.
  # @author David J. Davis
  def index 
    @subjects = Subject.all.order('name ASC').group_by{|d| d.name[0]}
    @letters = Database.letters
    @trials = Database.trials.prod.includes(:landing_page)
    @popular = Database.pop_list.prod.includes(:landing_page)
    @new_databases = Database.new_list.prod.includes(:landing_page)
    @open_access = Database.open_access_list.prod.includes(:landing_page)
    render :index
  end

  # AtoZ method sets the database for searching by titles
  # @author David J. Davis
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

  # Shows all the database in alphabetical order by title
  # @author David J. Davis
  def all 
    @letters = Database.letters
    @databases = Database.grouped_alpha
    @count = Database.total_count
    render :list_all
  end

  # Shows all of the subjects in the system that have an associated database 
  # @author David J. Davis
  def subject
    @subjects = Subject.all.order('name ASC').group_by{|d| d.name[0]}
    @letters = Database.letters
    render :subject
  end

  # Lists the databases by the subject selected.
  # @author David J. Davis
  def subject_databases
    subject_id = params[:id]
    @curated = active_curated_databases(subject_id)
    curated_ids = @curated.pluck(:database_id)
    @databases = Database.list_subjects(subject_id).includes(:landing_page).where.not(id: curated_ids).where(status: "production")
    @subject = Subject.find(subject_id)
    @count = @databases.count + @curated.count
    render :subject_db_list
  end

  private

  # Given a subject id returns a list of all production databases with that subject
  # From the DatabaseCurated model
  # @param subject_id [Integer] the id of the subject
  # @return [Array] of curated databases objects (only listing those in production)
  # @author Tracy A. McCormick
  # @created 2023-03-07
  def active_curated_databases(subject_id)
    curated_items = DatabaseCurated.includes(:database).where(subject_id: subject_id).order(sort: :desc)
    prod_curated_databases = []
    # loop over each id and check if it is in production
    curated_items.each do |db|
      # if not in production remove it from the list
      if Database.find(db.database_id).status == "production"
        prod_curated_databases << db
      end
    end
    return prod_curated_databases
  end
end
