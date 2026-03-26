class BookSeatJob < ApplicationJob
  queue_as :default

  def perform(seat_id)
    seat = Seat.find(seat_id)
    if seat.available?
      seat.book_seat
    end
  end
end
