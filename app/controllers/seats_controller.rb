class SeatsController < ApplicationController
    def book
        seat = Seat.find_by(seat_no: params[:seat_no])

        if seat && seat.available?
            seat.book_seat!
            render json: { message: "Seat booked successfully" }
        else
            render json: { message: "Seat is already Booked" }
        end
    end

    def cancel
        seat = Seat.find_by(seat_no: params[:seat_no])

        if seat && seat.booked?
            seat.cancel_seat!
            render json: { message: "Seat cancelled" }
        else
            render json: { message: "Seat not booked" }
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
end
