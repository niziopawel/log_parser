# frozen_string_literal: true

module LogParser
  class Error < StandardError; end
  class InvalidFile < Error; end
  class InvalidRow < Error; end
end
