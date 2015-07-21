class BookingsController < ApplicationController

before_action :authenticate_user!

	def index
	end

	def new
		@book_room = Booking.new
		@meeting_rooms_lists = MeetingRoom.all
		@employees_list = User.all
	end

	def create
		@book_room = Booking.new(booking_params)
		if @book_room.save
			flash[:success] = "Meeting room is successfully booked for you!!"
			redirect_to new_booking_path
		else
			@meeting_rooms_lists = MeetingRoom.all
		  @employees_list = User.all
		  render new_booking_path
		end
	end

	def booked_list
		@booked_room_list = Booking.where(status: false)
	end

	private

	def booking_params
		params.require(:booking).permit(:meeting_room_id,:starts_at,:ends_at, :agenda, :invitees => [])
			.merge( user_id: current_user.id,status: false)
	end

end
