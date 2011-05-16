$LOAD_PATH.unshift File.dirname(__FILE__) + '/..'
require "rubygems"
require "bundler/setup"
require "rspec"
require 'benchmark'

RSpec::Matchers.define :take_less_than do |n|
  chain :seconds do; end

  match do |block|
    @elapsed = Benchmark.realtime do
      block.call
    end
    @elapsed <= n
  end

end


