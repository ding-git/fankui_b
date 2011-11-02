class ReviewsController < InheritedResources::Base
  
  def new

    @review = Review.new
    
    respond_to do |format|
      format.js
    end
    
  end
  
  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to :back, notice: 'Chapter was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
