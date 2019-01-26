class Public::BaseController < ApplicationController
  def index 
    @subjects = Subject.all.order('name ASC').group_by{|d| d.name[0]}
    @letters = Database.letters
    render :index
  end
  
  def a_to_z 
    @letters = Database.letters
    @character = params[:character]
    if @character == "NUM"
      @databases = Database.number_list.production.order('name ASC')
    else 
      @databases = Database.alpha_list(@character).production.order('name ASC')
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
end
