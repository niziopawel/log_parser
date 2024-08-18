# frozen_string_literal: true

module LogParser
  class Parser
    attr_reader :options, :file_reader, :processor

    def initialize(options)
      @options = options
      @file_reader = LogParser::FileReader.new(options.file_path)
      @processor = LogParser::VisitsProcessor.new
    end

    def run
      file_reader.each_row do |row, index|
        processor.process_row(row, index)
      end

      processor.result.print
    rescue LogParser::Error => e
      abort("Something went wrong: #{e}")
    end
  end
end
