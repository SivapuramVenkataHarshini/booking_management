class SeatsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        render json: { message: "Seat Booking API Running" }
    end
    # def book
    #     seat = Seat.find_by(seat_no: params[:seat_no])

    #     if seat && seat.available?
    #         seat.book_seat!
    #         render json: { message: "Seat booked successfully" }
    #     else
    #         render json: { message: "Seat is already Booked" }
    #     end
    # end

    # def cancel
    #     seat = Seat.find_by(seat_no: params[:seat_no])

    #     if seat && seat.booked?
    #         seat.cancel_seat!
    #         render json: { message: "Seat cancelled" }
    #     else
    #         render json: { message: "Seat not booked" }
    #     end
    # end
    def cancel
        seat=Seat.find_by(seat_no: params[:seat_no])
        if seat && seat.available?
            CancelSeatJob.perform_later(seat.id)
            render json: { message: "Seat cancelling in progress" }
        else
            render json: { message: "Seat is not booked" }
        end
    end

    def status
        seats = Seat.all

        result = seats.map do |seat|
            {
              seat_no: seat.seat_no,
              status: seat.status
            }
        end
        
        render json: result
    end
    def status_of_one
        seat = Seat.find_by(seat_no: params[:seat_no])
        if seat
            render json: { status: seat.booked? ? "booked" : "available" }
        else
            render json: { error: "Seat not found" }
        end   
    end
    def book
        seat = Seat.find_by(seat_no: params[:seat_no])

        if seat && seat.available?
            BookSeatJob.perform_later(seat.id)
            render json: { message: "Seat booking in progress" }
        else
            render json: { message: "Seat is already Booked" }
        end
    end
end
