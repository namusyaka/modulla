require "modulla/version"

module Modulla
  def self.new(&block)
    Module.new.extend(self).class_eval(&block)
  end

  def self.extended(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def included(klass)
      klass.extend const_get(:ClassMethods) if const_defined?(:ClassMethods)
      klass ? reproduce(klass) : record(:class_eval, &block)
    end
  end

  private

  def record(method, *args, &block)
    record_keeper << [method, args, block]
  end

  def reproduce(klass)
    record_keeper.each do |method, args, block|
      klass.send(method, *args, &block)
    end
  end

  def record_keeper
    @record_keeper ||= []
  end

  def method_missing(method, *args, &block)
    record(method, *args, &block)
  end
end
