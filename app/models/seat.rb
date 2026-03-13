class Seat < ApplicationRecord
    validates :seat_no,presence:true,uniqueness:true
    def book_seat!
        update(booked:true) if available?
    end
    def cancel_seat!
        update(booked:false) if booked?
    end
    def booked?
        booked
    end
    def available?
        !booked
    end
    def status
        booked? ? "Booked": "Available"
    end
end
