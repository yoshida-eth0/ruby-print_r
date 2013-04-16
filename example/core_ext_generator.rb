#!/usr/bin/ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../lib"

require 'print_r'
require 'print_r/core_ext'

h = {
  :aaa => "AAA",
  :bbb => "BBB",
  :ccc => "CCC",
  :ddd => [
    "DDD1",
    "DDD2",
    "DDD3",
  ],
  :eee => {
    :eee1 => "EEE1",
    :eee2 => "EEE2",
    :eee3 => "EEE3",
  },
}
puts h.print_r
