# frozen_string_literal: true

module LogParser
  class OptParser
    Options = Struct.new(:file_path, keyword_init: true)

    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def parse!
      if argv.size == 1
        Options.new(file_path: argv[0])
      else
        abort("Provide path to log file e.g.: #{$PROGRAM_NAME} <FILE_PATH>") end
    end
  end
end
