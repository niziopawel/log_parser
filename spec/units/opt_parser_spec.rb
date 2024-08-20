# frozen_string_literal: true

RSpec.describe LogParser::OptParser do
  describe '#initialize' do
    subject(:opt_parser) { described_class.new(argv) }

    let(:argv) { ['path/to/file'] }

    describe '#initialize' do
      it 'initializes class with argv' do
        expect(opt_parser.argv).to eq(argv)
      end
    end

    describe 'parse!' do
      context 'with arguments' do
        it 'parses argv and initializes file_path with argv[0]' do
          options = opt_parser.parse!
          expect(options).to be_an_instance_of(LogParser::OptParser::Options)
          expect(options.file_path).to eq(argv[0])
        end
      end

      context 'without arguments' do
        let(:argv) { [] }

        it 'exits program' do
          expect do
            opt_parser.parse!
          end.to call_exit
            .with_message("Provide path to log file e.g.: #{$PROGRAM_NAME} <FILE_PATH>")
        end
      end
    end
  end
end
