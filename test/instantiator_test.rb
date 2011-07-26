require "test_helper"
require "instantiator"

class InstantiatorTest < Test::Unit::TestCase
  def test_should_instantiate_class_with_no_explicit_initialize
    klass = Class.new
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_with_initialize_with_no_parameters
    klass = Class.new do
      def initialize; end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_with_initialize_with_one_parameter
    klass = Class.new do
      def initialize(parameter_one); end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_with_initialize_with_multiple_parameters
    klass = Class.new do
      def initialize(parameter_one, parameter_two, parameter_three, parameter_four); end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_with_initialize_with_only_optional_parameters
    klass = Class.new do
      def initialize(*optional_parameters); end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_with_initialize_with_some_required_parameters_and_some_optional_parameters
    klass = Class.new do
      def initialize(parameter_one, parameter_two, *optional_parameters); end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_calls_method_on_parameter
    klass = Class.new do
      def initialize(parameter_one)
        parameter_one.foo
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_calls_method_on_multiple_parameters
    klass = Class.new do
      def initialize(parameter_one, parameter_two, parameter_three, parameter_four)
        parameter_one.foo
        parameter_two.foo
        parameter_three.foo
        parameter_four.foo
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_calls_method_on_result_of_calling_method_on_parameter
    klass = Class.new do
      def initialize(parameter_one)
        parameter_one.foo.bar
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_with_no_parameters
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new
          __new__("parameter_one")
        end
      end
      def initialize(parameter_one); end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_with_one_parameter
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(parameter_one)
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_with_multiple_parameters
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(parameter_one, parameter_two, parameter_three, parameter_four)
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_with_only_optional_parameters
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(*optional_parameters)
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_with_some_required_parameters_and_some_optional_parameters
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(parameter_one, parameter_two, *optional_parameters)
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_which_calls_method_on_parameter
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(parameter_one)
          parameter_one.foo
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_which_calls_method_on_multiple_parameters
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(parameter_one, parameter_two, parameter_three, parameter_four)
          parameter_one.foo
          parameter_two.foo
          parameter_three.foo
          parameter_four.foo
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

  def test_should_instantiate_class_which_defines_its_own_new_method_which_calls_method_on_result_of_calling_method_on_parameter
    klass = Class.new do
      class << self
        alias_method :__new__, :new
        def new(parameter_one)
          parameter_one.foo.bar
          __new__
        end
      end
    end
    instance = klass.instantiate
    assert_equal klass, instance.class
  end

end