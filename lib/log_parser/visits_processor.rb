# frozen_string_literal: true

module LogParser
  class VisitsProcessor
    attr_reader :counter

    def initialize
      @counter = VisitsCounter.new
    end

    def process_row(row, index)
      log_entry = build_log_entry(row)
      raise LogParser::InvalidRow, "Row: (#{index + 1}. #{row}) is invalid." unless log_entry.valid?

      counter.add(log_entry)
    end

    def result
      VisitsCounterResult.new(total: counter.total_visits, unique: counter.unique_visits)
    end

    private

    def build_log_entry(row)
      path, ip = row.split(' ')

      LogEntry.new(path:, ip:)
    end
  end
end
