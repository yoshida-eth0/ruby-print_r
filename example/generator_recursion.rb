#!/usr/bin/ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../lib"

require 'print_r'

h = {}
h[:val] = 123
h[:nest] = h
puts PrintR.generate(h)
