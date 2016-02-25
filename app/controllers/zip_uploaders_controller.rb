class ZipUploadersController < ApplicationController

	def new
		authorize :zip_upload
		@order = Order.find(params[:order_id])
		@zip_upload = @order.zip_uploaders.build
	end

	def create
		puts "999"*90
		puts params[:zip_uploader]
		puts "00"*90
		order  = Order.find(params[:order_id])
		@zip = order.zip_uploaders.build(params[:zip_uploader])
		# zip = params[:zip_uploader][:zip]
		# .original_filename
    # ext = File.extname(zip)
    # file_name = "#{File.basename(zip, ext).parameterize}_#{Time.now.to_i}#{ext}"
    # @zip.zip = file_name
    if @zip.save
    else
    end
	end
end
