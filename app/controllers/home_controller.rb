class HomeController < ApplicationController
  
  
  
  def index
    
    if !user_signed_in?
      @user_count = User.count
    else
      @presents = Present.order('created_at DESC').limit(10)
      @completed_count = Present.find(:all, :conditions => "resolve = true").count
      @undone_count = Present.find(:all, :conditions => "resolve = false").count
      render 'auth'
    end
  end

  autocomplete :user, :email, :full => true
  def show
    @user = User.new
  end
  
  def mail
        # UserMailer.welcome_email.deliver
    Delayed::Job.enqueue MailingJob.new()
  end

  def feed
    @cases = Case.all(:select => "title, id,description, updated_at", :order => "updated_at DESC", :limit => 20)

    respond_to do |format|
      format.rss { render :layout => false } #index.rss.builder
    end
  end

end
