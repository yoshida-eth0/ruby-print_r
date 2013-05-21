#!/usr/bin/ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../lib"

require 'print_r'

h = {
  :string => "HelloWorld!\nHelloWorld!\nHelloWorld!",
  :integer => 123,
  :float => 123.456,
  :true => true,
  :false => false,
  :range => (1..3),
  :nil => nil,
  :array => [
    "value1",
    "value2",
    "value3",
  ],
  :hash => {
    :key1 => "value1",
    :key2 => "value2",
    :key3 => "value3",
  },
  :object => Object.new.instance_eval{
    @key1 = "value1"
    @key2 = "value2"
    @key3 = "value3"
    self
  },
  :exception => Exception.new("aaa"),
}
h[:deep] = h.dup
puts PrintR.generate(h)
