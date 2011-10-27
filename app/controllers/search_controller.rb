class SearchController < ApplicationController
  def index
    @result = Present.find(:all, :conditions => ["title like ?","%"+params[:title]+"%"])
  end

end
