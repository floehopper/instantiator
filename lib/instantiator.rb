require "instantiator/version"
require "instantiator/core_ext"
require "blankslate"

module Instantiator

  UNSUPPORTED_NAMESPACES = %w(Introspection OptionParser::Switch URI Net).freeze
  UNSUPPORTED_CLASSES = %w(Introspection OptionParser::Switch Gem::Installer Gem::Package::TarInput Zlib::GzipReader Zlib::GzipWriter Zlib::GzipFile Zlib::ZStream Bundler::Dependency Bundler::Definition Digest::Base Binding UnboundMethod Method Proc Process::Status Dir File::Stat MatchData Struct Bignum Float Fixnum Integer Continuation Thread NameError::message SignalException FalseClass TrueClass Data Symbol NilClass Socket UNIXServer UNIXSocket TCPServer TCPSocket UDPSocket IPSocket BasicSocket Trying).freeze
  UNSUPPORTED_REGEX = Regexp.new((UNSUPPORTED_NAMESPACES.map { |ns| "^#{ns}::" } + UNSUPPORTED_CLASSES.map { |c| "^#{c}$" }).join("|")).freeze

  def self.unsupported_class?(klass)
    klass.to_s[UNSUPPORTED_REGEX]
  end

  class Error < StandardError; end

  class MethodInvocationSink < ::BlankSlate
    def method_missing(method_name, *args, &block)
      MethodInvocationSink.new
    end
    def to_str
      String.new
    end
    def to_int
      Integer(0)
    end
    def to_ary
      Array.new
    end
    def to_hash
      Hash.new
    end
  end

  module ClassMethods
    def instantiate
      if Instantiator.unsupported_class?(self)
        raise Error.new("#{self}.instantiate is not yet supported")
      end
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
        end
      end
      raise Error.new("Unable to instantiate #{self}")
    end
  end
end

class Class
  include Instantiator::ClassMethods
end
