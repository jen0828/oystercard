require 'oystercard'

describe Oystercard do
  
  let(:entry_station){ :entry_station }
  let(:exit_station){ :exit_station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  
  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  context ' during a journy' do
    it 'store the entry station'do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    
    it 'stores a journey' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include { journey }
    end

    it 'stores exit station' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect { subject.top_up 1}.to change { subject.balance }.by 1
    end
 
    it 'raise an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error 'Maximum balance exceeded'
    end
  end

  describe '#in_journey?'
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    
    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in(2) }.to raise_error "Insufficient balance to touch in"
    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    
    it 'can charge on touch out' do
      subject.top_up(20)
      subject.touch_in(2)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard:: MINIMUM_CHARGE)
    end
  end
end
    

