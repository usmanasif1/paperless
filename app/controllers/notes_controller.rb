class NotesController < ApplicationController

	def create
		if params[:message].length > 0
			order = Order.find(params[:order_id])
			note  = order.notes.build
			note.user_id = current_user.id
			note.message = params[:message]
			note.save!
			flash[:success] = "Successfully submitted."
		end
		redirect_to orders_path
	end
end
