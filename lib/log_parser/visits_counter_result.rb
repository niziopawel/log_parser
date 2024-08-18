# frozen_string_literal: true

module LogParser
  class VisitsCounterResult
    attr_reader :total, :unique

    def initialize(total:, unique:)
      @total = total
      @unique = unique
    end

    def print
      print_total
      puts
      print_unique
    end

    private

    def print_total
      puts 'Total visits:'
      sort(total).each do |path, count|
        puts "#{path} #{count} visits."
      end
    end

    def print_unique
      puts 'Unique visits:'
      sort(unique).each do |path, count|
        puts "#{path} #{count} unique visits."
      end
    end

    def sort(visits)
      visits.sort_by { |_path, count| -count }
    end
  end
end
