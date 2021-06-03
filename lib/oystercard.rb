class Oystercard

  MAXIMUM_BALANCE = 90
  MIN = 1

  attr_reader :balance, :in_journey, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'Maximum balance exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MIN
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MIN)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

