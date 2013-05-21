#!/usr/bin/ruby
# encoding=utf-8

module PrintR
  class Generator
    attr_reader :object

    def initialize(object)
      @object = object
      @recursive_objects = nil
    end

    def generate
      begin
        @recursive_objects = Hash.new(0)
        _to_str(object, 0)
      ensure
        @recursive_objects = nil
      end
    end

    def _to_str(obj, indent)
      tab1 = "    " * indent
      tab2 = "    " * (indent+1)
      str = nil
      object_type = obj.class.name

      is_recursive = 1<@recursive_objects[obj.object_id]
      @recursive_objects[obj.object_id] += 1

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
        str = "#{object_type} Object\n"

        if is_recursive
          str += " *RECURSION*"
        else
          str += tab1 + "(\n"
          obj.each_pair do |key,value|
            str += sprintf("%s[%s] => %s\n", tab2, key, _to_str(value, indent+2))
          end
          str += tab1 + ")\n"
        end
      else
        str = "#{obj}"
      end

      str
    end
  end
end
