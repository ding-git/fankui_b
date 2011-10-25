class HomeController < ApplicationController
  def index
    @presents = Present.all
  end

  def show
    redirect_to '/'
  end

end
