class SeatsController < ApplicationController
    def book
        seat = Seat.find_by(seat_no: params[:seat_no])

        if seat && seat.available?
            seat.book_seat!
            render json: { message: "Seat booked successfully" }
        else
            render json: { message: "Seat not available" }
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
end
