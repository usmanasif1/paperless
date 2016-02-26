class ZipUploadersController < ApplicationController

	def new
		authorize :zip_upload
		@order = Order.find(params[:order_id])
		@zip_upload = @order.zip_uploaders.build
	end

	def create
		order  = Order.find(params[:order_id])
		@zip = order.zip_uploaders.build(params[:zip_uploader])
    if @zip.save
    	flash[:success]  ="successfully uploaded"
    	redirect_to orders_path
    else
    	flash[:danger] = "Something went wrong."
    	redirect_to :back
    end
	end

	def files
		@order = Order.find(params[:order_id])
		@zip_uploaders  = @order.zip_uploaders
	end
end
