class OrdersController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :show, :create, :edit, :update]
	
	def index
		if params[:user_id].present?
			@user  = User.find(params[:user_id])
			@orders = @user.orders
		else
			@orders = current_user.orders
		end
	end

	def new
		@order = Order.new
	end

	def create
		@order = current_user.orders.build(params[:order])
		if @order.save
			Delayed::Job.enqueue SendEmailsJob.new(@order)
			flash[:success] = "Successfully submitted."
			redirect_to orders_path
		else
			flash[:danger] = "Please Fill All Fields"
			redirect_to :back
		end
	end

	def show
		@order = Order.find(params[:id])
		@notes = @order.notes.order('created_at DESC').includes(:user)
		if current_user.roles.where(name: ["Super Admin", "Admin"]).any?
			@admin = true
		end	
	end

	def edit
		@order = Order.find(params[:id])
	end


	def update
		order = Order.find(params[:id])
		order.update_attributes(params[:order])
		flash[:success] = "Successfully updated."
		redirect_to orders_path
	end

	def guest_order
		user = User.new
		user.email = params[:order][:email]
		user.phone = params[:order][:phone]
		user.password = rand(999999999)
		# cookie used only for the guest user. because there are two ways to signup. 1. signup   2. while posting order as guest then automatically new user regisered and sent an email for reset password if he/she want to continue. at this time no need to sign in.
		cookies[:login_user_as_guest] = "yes"
		if user.save
			role = user.user_roles.build
	    role.role_id = Role.find_by_name('User').id
	    role.save!
			order = user.orders.build(params[:order])
			order.save!
			user.send_reset_password_instructions
      cookies.delete :login_user_as_guest
			# Delayed::Job.enqueue SendEmailsJob.new(order)
			flash[:success]  = "Successfully submitted. Please check your email."
			redirect_to root_url
		else
			flash[:error]  = "Please fill all the fields."
			redirect_to :back
		end
	end
end
