require "instantiator/version"
require "blankslate"

module Instantiator

  class MethodInvocationSink < ::BlankSlate
    def method_missing(*args, &block)
      MethodInvocationSink.new
    end
  end

  module ClassMethods
    def instantiate
      if singleton_methods(false).map(&:to_sym).include?(:new)
        arity = method(:new).arity
      else
        arity = instance_method(:initialize).arity
      end
      number_of_parameters = arity >= 0 ? arity : -(arity + 1)
      new(*Array.new(number_of_parameters) { MethodInvocationSink.new })
    end
  end
end

class Class
  include Instantiator::ClassMethods
end
