class EventsController < ApplicationController
	
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_event, except: [:index, :new, :create]
	before_action :authenticate_editor!, only: [:new, :create, :update]
	before_action :authenticate_admin!, only: [:destroy, :publish]

	def index
		@events = Event.ultimos
	end

	def show
		@event.update_visits_count
		@comment = Comment.new
	end

	def new
		@event = Event.new
	end

	def edit
	end

	def create
		@event = current_user.events.new(event_params)

		if @event.save
			redirect_to @event
		else
			render :new
		end
	end

	def destroy
		@event.destroy
		redirect_to events_path
	end

	def update
		if @event.update(event_params)
			redirect_to @event
		else
			render :edit
		end
	end

	def publish
		@event.publish!
		redirect_to @event
	end

	private

		def set_event
			@event = Event.find(params[:id])
		end

		def event_params
			params.require(:event).permit(:title, :body, :cover)
		end

end
