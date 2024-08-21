# frozen_string_literal: true

require 'bundler/setup'
require 'English'
require 'simplecov'

SimpleCov.start

require_relative '../lib/log_parser'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end

RSpec::Matchers.define :call_exit do
  actual_message = nil

  match do |block|
    block.call
    false
  rescue SystemExit => e
    actual_message = e.message

    if @message
      @message == actual_message
    else
      true
    end
  end

  chain :with_message do |message|
    @message = message
  end

  failure_message do
    return "expected message: '#{@message}' but got: '#{actual_message}'" if @message

    "expected to call SystemExit but it didn't"
  end

  def supports_block_expectations?
    true
  end
end
