# frozen_string_literal: true

RSpec.describe LogParser::LogEntry do
  subject(:entry) { described_class.new(ip:, path:) }

  let(:ip) { '1.1.1.1' }
  let(:path) { '/home' }

  describe '#initialize' do
    it 'initializes ip and path' do
      expect(subject.ip).to eq(ip)
      expect(subject.path).to eq(path)
    end
  end

  describe '#valid?' do
    context 'when valid ip and path' do
      it 'returns true' do
        expect(subject.valid?).to be(true)
      end
    end

    context 'when ip or path invalid' do
      let(:ip) { nil }

      it 'returns true' do
        expect(subject.valid?).to be(false)
      end
    end
  end
end
