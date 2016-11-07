require File.expand_path('../lib/modulla', __dir__)
require 'test-unit'

class TestModulla < Test::Unit::TestCase
  module DSL
    extend Modulla

    foo { 'foo' }
    bar { 'bar' }
    baz { 'baz' }

    plus(1, 1)
  end

  Mock = Class.new do
    def self.foo(&block)
      @foo ||= block.call * 1
    end

    def self.bar(&block)
      @bar ||= block.call * 2
    end

    def self.baz(&block)
      @baz ||= block.call * 3
    end

    def self.plus(a, b)
      @plus ||= a + b
    end
  end

  test 'modulla enables DSL on module' do
    Mock.send(:include, DSL)
    assert { Mock.instance_variable_get(:@foo) == 'foo' }
    assert { Mock.instance_variable_get(:@bar) == 'barbar' }
    assert { Mock.instance_variable_get(:@baz) == 'bazbazbaz' }
    assert { Mock.instance_variable_get(:@plus) == 2 }
  end
end
