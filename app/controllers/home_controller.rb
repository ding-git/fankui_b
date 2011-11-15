class HomeController < ApplicationController
  
  
  
  def index
    
    if !user_signed_in?

    else
      @presents = Present.order('created_at DESC').limit(10)
      @completed_count = Present.find(:all, :conditions => "resolve = true").count
      @undone_count = Present.find(:all, :conditions => "resolve = false").count
      render 'auth'
    end
  end

  def show
    
    respond_to do |format|
      format.xml { render :xml => Case.all } # index.atom.builder
    end
  end
  
  def mail
        # UserMailer.welcome_email.deliver
    Delayed::Job.enqueue MailingJob.new()
  end


end
