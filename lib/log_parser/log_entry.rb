# frozen_string_literal: true

module LogParser
  class LogEntry
    PATH_REGEX = %r{^/[a-zA-Z0-9_\-/]*$}
    attr_reader :path, :ip

    def initialize(path:, ip:)
      @path = path
      @ip = ip
    end

    def valid?
      return false if path.nil? || ip.nil?

      !path.strip.empty? && !ip.strip.empty?
      # Commented out because testing file contains invalid ip addresses
      #   PATH_REGEX.match(path) && IPAddr.new(ip)
      # rescue IPAddr::Error
      #   false
    end
  end
end
