require "modulla/version"

module Modulla
  def self.new(&block)
    Module.new.extend(self).class_eval(&block)
  end

  def included(klass)
    reproduce(klass)
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
    record_keeper << [method, args, block]
  end
end
