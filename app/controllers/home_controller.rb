class HomeController < ApplicationController
  def index
    @presents = Present.order('created_at DESC').limit(10)
    @completed_count = Present.find(:all, :conditions => "resolve = true").count
    @undone_count = Present.find(:all, :conditions => "resolve = false").count
  end

  def show
    redirect_to '/'
  end

end
