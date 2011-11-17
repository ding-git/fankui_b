class MessagesController < InheritedResources::Base
  
  
  
  def create
    params[:message][:msg_to_id] = User.find_by_email(params[:message][:msg_to_id]).id
    params[:message][:request_ip] = request.remote_ip
    
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save!
        format.html { redirect_to :back, notice: 'Chapter was successfully created.' }
      else
        format.html { redirect_to :back, notice: 'Error' }
      end
    end
  end
  
  
end
