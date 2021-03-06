
module RideShare
  class Trip
    attr_reader :id, :passenger, :driver, :start_time, :end_time, :cost, :rating

    def initialize(input)
      @id = input[:id]
      @driver = input[:driver]
      @passenger = input[:passenger]
      @start_time = input[:start_time]
      @end_time = input[:end_time]
      @cost = input[:cost]
      @rating = input[:rating]

      unless rating == nil
        if rating > 5 || rating < 1
          raise ArgumentError.new("Invalid rating #{@rating}")
        end
      end

      unless end_time == nil
        if input[:start_time] > input[:end_time]
          raise ArgumentError.new("End time: #{input[:end_time]} cannot be earlier than Start time: #{input[:start_time]}")
        end
      end

    end

    def duration
      unless end_time == nil
        (end_time - start_time).to_i
      end
    end

  end # end of Trip class
end # end of RideShare module
