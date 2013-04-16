#!/usr/bin/ruby
# encoding=utf-8

module PrintR
  class Generator
    attr_reader :object

    def initialize(object)
      @object = object
    end

    def generate
      _to_str(object, 0)
    end

    def _to_str(obj, indent)
      tab1 = "    " * indent
      tab2 = "    " * (indent+1)
      str = nil
      type = "Array"

      if obj.kind_of?(Hash)
        type = "Array"
      elsif obj.kind_of?(Array)
        type = "Array"
        obj2 = {}
        obj.each_with_index do |value,i|
          obj2[i] = value
        end
        obj = obj2
      elsif obj.kind_of?(String)
      elsif obj.respond_to?(:instance_variables)
        type = "#{obj.class.name} Object"
        obj = obj.instance_variables.inject({}) {|h,key|
          key_str = key.to_s.sub("@", "")
          h[key_str] = obj.instance_variable_get(key)
          h
        }
      end

      if obj.kind_of?(Hash)
        str = "#{type}\n"
        str += tab1 + "(\n"
        obj.each_pair do |key,value|
          str += sprintf("%s[%s] => %s\n", tab2, key, _to_str(value, indent+2))
        end
        str += tab1 + ")\n"
      else
        str = obj.to_s
      end

      str
    end
  end
end
