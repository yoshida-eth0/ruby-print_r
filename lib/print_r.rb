#!/usr/bin/ruby
# encoding=utf-8

require 'print_r/parser'
require 'print_r/generator'

module PrintR
  class << self
    def parse(text)
      Parser.new(text).parse
    end

    def generate(object)
      Generator.new(object).generate
    end
  end
end
