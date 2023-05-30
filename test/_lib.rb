require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/spec'
require 'mocha'

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../lib')))

require 'mosql'
require 'mocha/minitest'

module MoSQL
  class Test < ::MiniTest::Spec
    def assert_method_called(obj, method_name, expected_count = nil)
      count = 0
      called = false
      obj.singleton_class.prepend(Module.new {
        define_method(method_name) do |*args|
          count += 1
          called = true
          super(*args)
        end
      })

      yield

      if expected_count != 0
        assert(called, "Expected method #{method_name} to be called")
      end

      if expected_count.is_a?(Numeric)
        assert_equal(
          expected_count, count,
          "Expected method #{method_name} to be called #{expected_count} times, but was called #{count} times"
        )
      end
    end

    def assert_method_not_called(obj, method_name)
      assert_method_called(obj, method_name, 0) { yield }
    end

    def setup
      # Put any stubs here that you want to apply globally
    end
  end
end
