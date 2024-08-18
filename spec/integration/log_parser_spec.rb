# frozen_string_literal: true

RSpec.describe 'log parser spec' do
  subject(:parser) { LogParser::Parser.new(options) }

  let(:options) { LogParser::OptParser.new(argv).parse! }
  let(:argv) { [] }

  context 'when without options' do
    it 'exits with a error message' do
      expect { parser.run }.to call_exit.with_message(
        "Provide path to log file e.g.: #{$PROGRAM_NAME} <FILE_PATH>"
      )
    end
  end

  context 'when unparsable file is provided' do
    let(:argv) { ['spec/fixtures/unparsable.log'] }

    it 'exits with error message' do
      expect { parser.run }.to call_exit.with_message(
        'Something went wrong: Row: (3. /home184.123.665.067) is invalid.'
      )
    end
  end

  context 'when invalid path to file' do
    let(:argv) { ['path/invalid/file.log'] }

    it 'exits with error message' do
      expect { parser.run }.to call_exit.with_message(
        "Something went wrong: File #{argv[0]} missing or invalid."
      )
    end
  end

  context 'when parsable file is provided' do
    let(:argv) { ['spec/fixtures/parsable.log'] }

    it 'prints parsing result' do
      expect do
        parser.run
      end.to output(<<~TEXT).to_stdout_from_any_process
        Total visits:
        /help_page/1 3 visits.
        /contact 3 visits.
        /home 1 visits.

        Unique visits:
        /contact 3 unique visits.
        /help_page/1 1 unique visits.
        /home 1 unique visits.
      TEXT
    end
  end
end
