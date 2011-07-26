== Instantiator ==

I want to be able to instantiate an arbitrary Ruby class without knowing anything about the constructor.

=== Usage ===

    class ArbitraryClass
      def initialize(arg1, arg2, *other_args)
        # stuff
      end
    end

    require "instantiator"
    
    instance = ArbitraryClass.instantiate
    
    p instance.class # => ArbitraryClass