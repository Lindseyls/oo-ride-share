require_relative 'spec_helper'

describe "TripDispatcher class" do
  describe "Initializer" do
    it "is an instance of TripDispatcher" do
      dispatcher = RideShare::TripDispatcher.new
      dispatcher.must_be_kind_of RideShare::TripDispatcher
    end

    it "establishes the base data structures when instantiated" do
      dispatcher = RideShare::TripDispatcher.new
      [:trips, :passengers, :drivers].each do |prop|
        dispatcher.must_respond_to prop
      end

      dispatcher.trips.must_be_kind_of Array
      dispatcher.passengers.must_be_kind_of Array
      dispatcher.drivers.must_be_kind_of Array
    end
  end # end of describe "Initializer"

  describe "find_driver method" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "throws an argument error for a bad ID" do
      proc{ @dispatcher.find_driver(0) }.must_raise ArgumentError
    end

    it "finds a driver instance" do
      driver = @dispatcher.find_driver(2)
      driver.must_be_kind_of RideShare::Driver
    end
  end # end of describe "find_driver method"

  describe "find_passenger method" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "throws an argument error for a bad ID" do
      proc{ @dispatcher.find_passenger(0) }.must_raise ArgumentError
    end

    it "finds a passenger instance" do
      passenger = @dispatcher.find_passenger(2)
      passenger.must_be_kind_of RideShare::Passenger
    end
  end # end of describe "find_passenger method"

  describe "load_trips methods" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "accurately loads driver information into drivers array" do
      first_driver = @dispatcher.drivers.first
      last_driver = @dispatcher.drivers.last

      first_driver.name.must_equal "Bernardo Prosacco"
      first_driver.id.must_equal 1
      first_driver.status.must_equal :UNAVAILABLE
      last_driver.name.must_equal "Minnie Dach"
      last_driver.id.must_equal 100
      last_driver.status.must_equal :AVAILABLE
    end

    it "accurately loads passenger information into passengers array" do
      first_passenger = @dispatcher.passengers.first
      last_passenger = @dispatcher.passengers.last

      first_passenger.name.must_equal "Nina Hintz Sr."
      first_passenger.id.must_equal 1
      last_passenger.name.must_equal "Miss Isom Gleason"
      last_passenger.id.must_equal 300
    end

    it "accurately loads trip info and associates trips with drivers and passengers" do
      trip = @dispatcher.trips.first
      driver = trip.driver
      passenger = trip.passenger

      driver.must_be_instance_of RideShare::Driver
      driver.trips.must_include trip
      passenger.must_be_instance_of RideShare::Passenger
      passenger.trips.must_include trip
    end
  end # end of describe "loader methods"

  describe "available_driver method" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "accurately finds the fist available driver" do
      first_driver = @dispatcher.available_driver

      first_driver.name.must_equal "Emory Rosenbaum"
      first_driver.id.must_equal 2
      first_driver.status.must_equal :AVAILABLE
    end

    it "accurately finds the next available driver" do
      trip = @dispatcher.request_trip(21)
      second_driver = trip.driver
      second_driver = @dispatcher.available_driver

      second_driver.name.must_equal "Daryl Nitzsche"
      second_driver.id.must_equal 3
      second_driver.status.must_equal :AVAILABLE
    end

    # TODO: add a edge case here
  end

  describe "request trip methods" do
    before do
      @dispatcher = RideShare::TripDispatcher.new
    end

    it "accurately loads passenger information into the new trip" do
      dispatcher_1 = @dispatcher.request_trip(1)
      first_passenger = dispatcher_1.passenger

      first_passenger.name.must_equal "Nina Hintz Sr."
      first_passenger.id.must_equal 1

      dispatcher_2 = @dispatcher.request_trip(21)
      last_passenger = dispatcher_2.passenger

      last_passenger.name.must_equal "Jovani Nienow"
      last_passenger.id.must_equal 21
    end

    it "accurately loads trip info and associates trips with drivers and passengers" do
      trip = @dispatcher.request_trip(1)
      driver = trip.driver
      passenger = trip.passenger

      driver.must_be_instance_of RideShare::Driver
      driver.trips.must_include trip
      passenger.must_be_instance_of RideShare::Passenger
      passenger.trips.must_include trip

      driver.name.must_equal "Emory Rosenbaum"
      driver.id.must_equal 2
      driver.status.must_equal :UNAVAILABLE
    end

    it "accurately returns the new trip" do
      trip = @dispatcher.request_trip(21)
      driver = trip.driver
      passenger = trip.passenger

      trip.id.must_equal 601
      driver.name.must_equal "Emory Rosenbaum"
      driver.id.must_equal 2
      driver.status.must_equal :UNAVAILABLE
      passenger.name.must_equal "Jovani Nienow"
      passenger.id.must_equal 21
      trip.start_time.must_be_kind_of Time
      trip.end_time.must_be_nil
      trip.cost.must_be_nil
      trip.rating.must_be_nil
    end
  end # end of describe "loader methods"

end # end of describe "TripDispatcher class"
