class DocumentsController < ApplicationController

	# form to upload a new document
	def new
		@user = current_user
		@document = @user.documents.new
	end

	# create action for new document
	def create
		@user = current_user
		@document = @user.documents.new(doc_params)
		if @user.save
			redirect_to user_documents_path
		else
			@errors = @user.errors.full_messages + @document.errors.full_messages
			render "new"
		end
	end

	# show all documents uploaded for one user
	def index
		if logged_in?
			@user = current_user
			@documents = @user.documents
		else
      flash[:access] = "Unauthorized access, please contact an administrator if you believe this error is incorrect."
      # can change to redirect root_path once we have established what that is
      redirect_to '/'
    end
	end

	# show one document (in full resolution if multiple sizes are used)
	def show
		@user = current_user
		doc = Document.find(params[:id])
		if logged_in? && @user.documents.include?(doc)
			@document = doc
		else
			flash[:access] = "Unauthorized access, please contact an administrator if you believe this error is incorrect."
			redirect_to '/'
		end
	end

	private 
	def doc_params
		params.require(:document).permit(:name, :media, :remote_media_url)
	end
end