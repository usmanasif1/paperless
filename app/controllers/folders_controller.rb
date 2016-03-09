class FoldersController < ApplicationController

	def index
		if params[:user_id].present?
			@user = User.find(params[:user_id])
		else
			@user = current_user
		end
		# @folder = Folder.find(@user.folder_id)
		@root_folder  = @user.folders.where('parent_id IS NULL').try(:first)
		@folder = @root_folder
		@folders = @user.folders.where("parent_id IS NOT NULL AND parent_id = ?", @root_folder.id)
		# @files = @folder.try(:zip_uploaders)
	end

	def new
		@target_folder = Folder.find(params[:folder_id])
		@folder = Folder.new
	end

	def create
		@target_folder = Folder.find(params[:folder_id])
		folder = Folder.new(params[:folder])
		folder.parent_id = @target_folder.id
		folder.user_id = @target_folder.user_id
		if folder.save
			user = User.where(folder_id: @target_folder.id).try(:first)
			redirect_to folder_path(@target_folder)
		else
			redirect_to :back, :notice=> "Something wnet wrong."
		end
	end

	def show
		@folder = Folder.find(params[:id])
		if current_user.roles.where(name: ["Super Admin", "Admin"]).any?
			user = @folder.user	
			@root_folder = user.folders.where('parent_id IS NULL').try(:first)
		else
			@root_folder = current_user.folders.where('parent_id IS NULL').try(:first)
		end
		@folders = Folder.where(parent_id: @folder.id)
	end

	def get_folders
		id = params[:id]
		if id == 'root'
			folder  = current_user.folders.where('parent_id IS NULL').try(:first)
			folders = Folder.where(parent_id: folder.id)
		else
			# folder  = current_user.folders.where('parent_id IS NULL').try(:first)
			folders = Folder.where(parent_id: id)
		end
		@folder_hash = []

		folders.each do |f|
			if Folder.where(parent_id: f.id).present?
				sub_fdr = 1
			else
				sub_fdr = 0
			end
			fdr_att = {
        "fdr_id" => "#{f.id}",
        "name" => "#{f.name}",
        "sub_fdr" => sub_fdr
      }	
      @folder_hash << fdr_att
		end
		return render json: @folder_hash
	end

	def get_html
		@folder = Folder.find(params[:id])
		user = @folder.user	
		@root_folder = user.folders.where('parent_id IS NULL').try(:first)
		@folders = Folder.where(parent_id: @folder.id)
		return render partial: 'shared/page_view' 
	end

	def edit
		@folder = Folder.find(params[:id])
	end

	def update
		@folder = Folder.find(params[:id])
		@folder.update_attributes(params[:folder])
		parent_folder = Folder.where(parent_id: @folder.parent_id).first
		redirect_to folder_path(parent_folder)
	end

	def get_folder_list
		folders = current_user.folders.where("parent_id IS NOT NULL")
		return render json: folders
	end

	def move_folder
		str = params[:move_file_id]
		arr = str.split('-')
		move_to_folder = Folder.find(params[:move_to])
		if(arr[1] == 'folder')
			folder = Folder.find(arr[0])
			# Scenario# => 1
			if folder.id == move_to_folder.parent_id
				move_to_folder.parent_id = folder.parent_id
				move_to_folder.save!
			end
	    folder.parent_id = move_to_folder.id
			folder.save!	
		else
			file = ZipUploader.find(arr[0])
			file.folder_id = move_to_folder.id
			file.save!
		end
		flash[:success] = "successfully updated."
		redirect_to :back
	end
end
