class ContactsController < ApplicationController

	before_action :authenticate_admin!, only: [:destroy, :update]

	def index
		@contact = Contact.new
	end

	def show
	end

	def new
		redirect_to contacts_path
	end

	def create
		@contact = Contact.new(contact_params)

		if @contact.save
			redirect_to @contact
		else
			render :index
		end
	end

	def destroy
		@contact.destroy
		redirect_to contacts_path
	end

	def update
	end

	private

		def set_contact
			@contact = Contact.find(params[:id])
		end

		def contact_params
			params.require(:contact).permit(:first_name, :last_name, :email,
											:company, :position, :comment, 
											:receive_information)
		end
end
