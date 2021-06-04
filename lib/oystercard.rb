class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail 'Maximum balance exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_CHARGE
    @in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    journey_history
    @entry_station = nil
    
  end

  def journey_history
    @journeys  << {entry_station: @entry_station, exit_station: @exit_station}
   end

  private

  def deduct(amount)
    @balance -= amount
  end
end

