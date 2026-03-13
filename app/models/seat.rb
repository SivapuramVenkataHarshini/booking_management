class Seat < ApplicationRecord
    validates :seat_no,presence:true,uniqueness:true,numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 50}
end
