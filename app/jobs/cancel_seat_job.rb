class CancelSeatJob < ApplicationJob
  queue_as :default

  def perform(seat_id)
    seat=Seat.find_by(seat_id)
    if seat.booked?
      seat.cancel_seat!
    end
  end
end
