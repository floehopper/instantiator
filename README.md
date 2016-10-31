## Instantiator [![Build Status](https://travis-ci.org/floehopper/instantiator.svg?branch=master)](https://travis-ci.org/floehopper/instantiator) [![Gem Version](https://badge.fury.io/rb/instantiator.png)](http://badge.fury.io/rb/instantiator)

I want to be able to instantiate an arbitrary Ruby class without knowing anything about the constructor.

The initial requirement for this has come from my [Introspection](https://github.com/floehopper/introspection) project.

### Usage

    class ArbitraryClass
      def initialize(arg1, arg2, *other_args)
        # stuff
      end
    end

    require "instantiator"

    instance = ArbitraryClass.instantiate

    p instance.class # => ArbitraryClass
