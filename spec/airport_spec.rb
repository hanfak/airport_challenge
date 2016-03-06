require 'airport'

describe Airport do
  subject(:airport) { described_class.new }
  it { expect(subject).to respond_to(:land).with(1).argument }
  it { expect(subject).to respond_to(:take_off).with(1).argument }

  describe '#initialize' do
    it 'starts with no planes' do
      expect(subject.planes_in_airport).to be_empty
    end
  end

  describe '#land' do
    let (:plane) {double(:plane)}

    it 'stores plane in an airport' do
      allow(plane).to receive(:landed).and_return(true)
      subject.land(plane)
      expect(subject.planes_in_airport).to include plane
    end
  end

  describe '#take_off' do
    let (:plane) {double(:plane)}

    it 'raises error if plane is not at airport' do
      allow(plane).to receive(:at_airport?).and_return(false)
      error_message = 'Plane not at airport'
      expect {subject.take_off(plane)}.to raise_error(error_message)
    end

    it 'removes plane from airport' do
      allow(plane).to receive(:at_airport?).and_return(true)
      allow(plane).to receive(:landed).and_return(true)
      allow(plane).to receive(:taken_off).and_return(true)
      subject.land(plane)
      subject.take_off(plane)
      expect(subject.planes_in_airport).not_to include plane
    end
  end
end
