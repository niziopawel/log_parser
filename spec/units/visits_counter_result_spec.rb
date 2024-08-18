# frozen_string_literal: true

RSpec.describe LogParser::VisitsCounterResult do
  subject(:result) { described_class.new(total: total_visits, unique: unique_visits) }

  let(:total_visits) { { '/home' => 2, '/about' => 3 } }
  let(:unique_visits) { { '/home' => 1, '/about' => 2 } }

  describe '#initialize' do
    it 'initializes counter results' do
      expect(result.unique).to eq(unique_visits)
      expect(result.total).to eq(total_visits)
    end
  end

  describe '#print' do
    it 'sorts counters and prints results' do
      expect do
        result.print
      end.to output(<<~TEXT).to_stdout_from_any_process
        Total visits:
        /about 3 visits.
        /home 2 visits.

        Unique visits:
        /about 2 unique visits.
        /home 1 unique visits.
      TEXT
    end
  end
end
