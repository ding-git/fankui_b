class ReviewsController < InheritedResources::Base
  
  def new

    @review = Review.new
    
    respond_to do |format|
      format.js
    end
   
  end
  

  
end
