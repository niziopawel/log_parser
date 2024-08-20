# frozen_string_literal: true

RSpec.describe LogParser::FileReader do
  let(:file_reader) { described_class.new(file_path) }

  let(:file_path) { 'spec/fixtures/parsable.log' }

  describe '#initialize' do
    it 'initializes class with file_path' do
      expect(file_reader.file_path).to eq(file_path)
    end
  end

  describe '#each_row' do
    context 'when file exits' do
      it 'yields each line of the file with index' do
        lines = []

        file_reader.each_row do |row, index|
          lines << { row:, index: }
        end

        expect(lines).to eq([
                              { row: '/help_page/1 126.318.035.038', index: 0 },
                              { row: '/help_page/1 126.318.035.038', index: 1 },
                              { row: '/help_page/1 126.318.035.038', index: 2 },
                              { row: '/contact 126.318.035.038', index: 3 },
                              { row: '/contact 722.247.931.582', index: 4 },
                              { row: '/contact 184.123.665.067', index: 5 },
                              { row: '/home 184.123.665.067', index: 6 }
                            ])
      end
    end

    context 'when file does not exit' do
      let(:file_path) { '/path/invalid' }

      it 'raises LogParser::InvalidFile error' do
        expect do
          file_reader.each_row { |row, index| p row, index }
        end.to raise_error(LogParser::InvalidFile)
      end
    end
  end
end
