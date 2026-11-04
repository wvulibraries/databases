# Public::SearchController 
# this controller will be for landing pages. 
class Public::SearchController < ApplicationController
  # Queries the search and returns result.
  # @author David J. Davis
  def index
    clean_term = params[:query].to_s.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!}, '')
    page = params[:page]
    @search_term = Sanitize.fragment clean_term

    if @search_term.blank?
      @databases = Database.prod.order(:name).page(page)
    else
      @results = Database.search(@search_term).page(page)
      @databases = @results.records
    end
  end
end