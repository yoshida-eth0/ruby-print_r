#!/usr/bin/ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../lib"

require 'print_r'
require 'pp'

text = `php "#{File.dirname(__FILE__)}/parse_data.php"`

obj = PrintR.parse(text)
pp obj
