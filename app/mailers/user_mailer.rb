class UserMailer < ActionMailer::Base

   def registration_confirmation(user,book)
   	 @user = user
   	 @book = book
     mail(:to => user.email, :subject => "Registered", :from => "usmantest@devsinc.com")
   end

   def notification(user,order)
   	@order = order
   	@user = user
   	mail(:to => @user.email, :subject => "Order Notification", :from => "usmantest@devsinc.com")
   end

end
