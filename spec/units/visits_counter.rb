# frozen_string_literal: true

RSpec.describe LogParser::VisitsCounter do
  subject(:counter) { described_class.new }

  describe '#add' do
    let(:log_entries) do
      [
        LogParser::LogEntry.new(path: '/home', ip: '1.1.1.1'),
        LogParser::LogEntry.new(path: '/home', ip: '1.1.1.1'),
        LogParser::LogEntry.new(path: '/about', ip: '2.2.2.2'),
        LogParser::LogEntry.new(path: '/about', ip: '3.3.3.3')
      ]
    end

    it 'adds entry to counter hashes' do
      log_entries.each do |entry|
        counter.add(entry)
      end

      expect(counter.total_visits).to eq({ '/home' => 2, '/about' => 2 })
      expect(counter.unique_visits).to eq({ '/home' => 1, '/about' => 2 })
      expect(counter.unique_ips).to eq({ '/home' => Set.new(['1.1.1.1']),
                                         '/about' => Set.new(['2.2.2.2', '3.3.3.3']) })
    end
  end
end
