# frozen_string_literal: true

RSpec.describe LogParser::VisitsProcessor do
  subject(:processor) { described_class.new }

  let(:row) { '/home 192.123.123.1' }

  describe '#initialize' do
    it 'initializes visits counter' do
      expect(processor.counter).to be_instance_of(LogParser::VisitsCounter)
    end
  end

  describe '#process_row' do
    let(:visits_counter) { double(LogParser::VisitsCounter) }

    context 'when valid row' do
      it 'builds log entry from a row' do
        expect(LogParser::LogEntry).to receive(:new).with({ path: '/home',
                                                            ip: '192.123.123.1' }).and_call_original

        processor.process_row(row, 1)
      end

      it 'passes entry log to visit counter' do
        expect(processor.counter).to receive(:add)

        processor.process_row(row, 1)
      end
    end

    context 'when invalid row' do
      let(:row) { 'invalid' }

      it 'raises LogParser::InvalidRow error' do
        expect { processor.process_row(row, 1) }.to raise_error(LogParser::InvalidRow)
      end
    end
  end

  describe '#result' do
    it 'returns visits counter result' do
      processor.process_row(row, 1)

      result = processor.result
      expect(result).to be_instance_of(LogParser::VisitsCounterResult)
      expect(result.total).to eq({ '/home' => 1 })
      expect(result.unique).to eq({ '/home' => 1 })
    end
  end
end
