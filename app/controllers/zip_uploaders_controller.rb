class ZipUploadersController < ApplicationController

	def new
		authorize :zip_upload
		@order = Order.find(params[:order_id])
		@zip_upload = @order.zip_uploaders.build
	end

	def create
		# order  = Order.find(params[:order_id])
		# @zip = order.zip_uploaders.build(params[:zip_uploader])
  #   if @zip.save
  #   	flash[:success]  ="successfully uploaded"
  #   	redirect_to request.referrer
  #   else
  #   	flash[:danger] = "Something went wrong."
  #   	redirect_to :back
  #   end


  # following code integratde with folder
		folder  = Folder.find(params[:folder_id])
		@zip = folder.zip_uploaders.build(params[:zip_uploader])
    if @zip.save
    	flash[:success]  ="successfully uploaded"
    	redirect_to request.referrer
    else
    	flash[:danger] = "Something went wrong."
    	redirect_to :back
    end


	end

	def files
		@order = Order.find(params[:order_id])
		@files  = @order.zip_uploaders
	end

	def download
		file = ZipUploader.find(params[:id])
		url = file.zip.url
		data = open(url).read
		send_data data, :disposition => 'attachment', :filename=> "#{file.zip_identifier}"
	end
end
