require "instantiator/version"
require "blankslate"

module Instantiator

  class InstantiationError < StandardError; end

  class MethodInvocationSink < ::BlankSlate
    def method_missing(method_name, *args, &block)
      MethodInvocationSink.new
    end
    def to_str
      String.new
    end
  end

  module ClassMethods
    def instantiate
      if singleton_methods(false).map(&:to_sym).include?(:new)
        arity = method(:new).arity
      else
        arity = instance_method(:initialize).arity
      end
      numbers_of_parameters = arity >= 0 ? [arity] : (-(arity + 1)..5-(arity + 1)).to_a
      instance = nil
      numbers_of_parameters.each do |number_of_parameters|
        begin
          instance = new(*Array.new(number_of_parameters) { MethodInvocationSink.new })
          return instance if instance
        rescue ArgumentError => e
        ensure
        end
      end
      raise InstantiationError.new("Unable to instantiate #{self}")
    end
  end
end

class Class
  include Instantiator::ClassMethods
end
