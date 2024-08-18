# frozen_string_literal: true

module LogParser
  class FileReader
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def each_row(&block)
      File.foreach(file_path, "\n", chomp: true).with_index(&block)
    rescue Errno::ENOENT
      raise LogParser::InvalidFile, "File #{file_path} missing or invalid."
    end
  end
end
