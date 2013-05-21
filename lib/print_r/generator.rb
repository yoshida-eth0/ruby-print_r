#!/usr/bin/ruby
# encoding=utf-8

module PrintR
  class Generator
    @@default_max_allowed_stack_size = 10
    @@default_raise_stack_overflow_exception = false

    # class variables accessor
    def self.default_max_allowed_stack_size; @@default_max_allowed_stack_size; end
    def self.default_max_allowed_stack_size=(val); @@default_max_allowed_stack_size = val.to_i; end

    def self.default_raise_stack_overflow_exception; @@default_raise_stack_overflow_exception; end
    def self.default_raise_stack_overflow_exception=(val); @@default_raise_stack_overflow_exception = val.present?; end

    # instance variables accessor
    attr_reader :object
    attr_reader :max_allowed_stack_size
    attr_reader :raise_stack_overflow_exception

    def initialize(object, max_allowed_stack_size=nil, raise_stack_overflow_exception=nil)
      @object = object
      @max_allowed_stack_size = max_allowed_stack_size.nil? ? @@default_max_allowed_stack_size : max_allowed_stack_size.to_i
      @raise_stack_overflow_exception = raise_stack_overflow_exception.nil? ? @@default_raise_stack_overflow_exception : !!raise_stack_overflow_exception
    end

    def generate
      _to_str(object, 0)
    end

    def _to_str(obj, indent)
      tab1 = "    " * indent
      tab2 = "    " * (indent+1)
      str = nil
      type = obj.class.name

      case obj
      when Array
        # hash of values with index
        obj2 = {}
        obj.each_with_index do |value,i|
          obj2[i] = value
        end
        obj = obj2
      when Hash
        # do nothing
      when TrueClass
        # fixnum 1
        obj = 1
      when FalseClass
        # fixnum 0
        # not compatible with print_r() of PHP
        obj = 0
      when NilClass
        # empty string
        obj = ""
      when Exception
        # to hash
        obj = obj.instance_eval{
          {
            :message => self.message,
            :backtrace => self.backtrace,
          }
        }
      else
        if obj.respond_to?(:instance_variables) && 0<obj.instance_variables.length
          # instance_variables
          obj = obj.instance_variables.inject({}) {|h,key|
            key_str = key.to_s.sub("@", "")
            h[key_str] = obj.instance_variable_get(key)
            h
          }
        elsif obj.respond_to?(:to_s)
          # to_s
          obj = obj.to_s
        end
      end

      # to string
      case obj
      when Hash
        # check stack size
        if max_allowed_stack_size<=indent/2
          if raise_stack_overflow_exception
            raise RuntimeException, "PrintR::Generator stack overflow"
          else
            return "PrintR::Generator stack overflow"
          end
        end

        # recursive _to_str
        str = "#{type} Object\n"
        str += tab1 + "(\n"
        obj.each_pair do |key,value|
          str += sprintf("%s[%s] => %s\n", tab2, key, _to_str(value, indent+2))
        end
        str += tab1 + ")\n"
      else
        str = "#{obj}"
      end

      str
    end
  end
end
