class UserMailer < ActionMailer::Base
  default from: "test_rails@126.com"
  
   def welcome_email
     mail(:to => '1055252224@qq.com',
          :subject => "Welcome to #{Time.now}") do |format|
       format.html
    end
   end

end
