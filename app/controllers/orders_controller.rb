class OrdersController < ApplicationController

	def index
		if current_user.roles.where(name: ["Super Admin", "Admin"]).any?
			@orders = Order.all
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
			# id = @order.id
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
	end

	def guest_order
		user = User.new
		user.email = params[:order][:email]
		user.phone = params[:order][:phone]
		user.password = rand(999999999)
		if user.save
			role = user.user_roles.build
	    role.role_id = Role.find_by_name('User').id
	    role.save!
			order = user.orders.build(params[:order])
			order.save!
    	# Dir.mkdir("#{Rails.root}/public/#{user.email}") unless File.exists?("#{Rails.root}/public/#{user.email}")
			# File.dirname("#{Rails.root}/public/uploads/#{user.email}") unless File.directory?("#{Rails.root}/public/#{user.email}")
			user.send_reset_password_instructions
			Delayed::Job.enqueue SendEmailsJob.new(order)
			flash[:success]  = "Successfully submitted. Please check your email."
			redirect_to root_url
		else
			flash[:error]  = "Please fill all the fields."
			redirect_to :back
		end
	end
end
