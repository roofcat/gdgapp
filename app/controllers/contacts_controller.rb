class ContactsController < ApplicationController

	def index
		@contact = Contact.new
	end

	def show
	end

	def new
		@contact = Contact.new
	end

	def edit
	end

	def create
		@contact = Contact.new(contact_params)

		if @contact.save
			redirect_to @contact
		else
			render :new
		end
	end

	def destroy
		@contact.destroy
		redirect_to contacts_path
	end

	def update
		if @contact.update(contact_params)
			redirect_to @contact
		else
			render :edit
		end
	end

	private

		def set_contact
			@contact = Contact.find(params[:id])
		end

		def contact_params
			params.require(:contact).permit(:first_name, :last_name, :email,
											:company, :position, :comment, 
											:recive_information)
		end
end
