# frozen_string_literal: true

module LogParser
  class VisitsCounter
    attr_reader :total_visits, :unique_visits, :unique_ips

    def initialize
      @total_visits = Hash.new(0)
      @unique_visits = Hash.new(0)
      @unique_ips = Hash.new { |hash, key| hash[key] = Set.new }
    end

    def add(log_entry)
      total_visits[log_entry.path] += 1
      return unless unique_ips[log_entry.path].add?(log_entry.ip)

      unique_visits[log_entry.path] += 1
    end
  end
end
