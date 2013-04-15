#!/usr/bin/ruby
# encoding=utf-8

module PrintR
  class Parser
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def parse
      _to_object(text, 0)
    end

    def _to_object(str, indent)
      str = str.strip
      sp = "    " * indent
      md = str.match(/^(?:Array|.*? Object)\n#{sp}\(\n(.+)#{sp}\)$/m)
      if md
        obj = _to_key_values(md[1].split(/(\r\n|\r|\n)/), indent+1)

        obj.each do |key, value|
          obj[key] = _to_object(value, indent+2)
        end
      else
        obj = str
      end
      obj
    end

    def _to_key_values(lines, indent)
      sp = "    " * indent
      h = {}
      tmp_key = nil
      tmp_val = ""
      lines.each do |line|
        md = line.match(/^#{sp}\[([^\]]+)\] => (.*)/)
        if md
          if tmp_key
            h[tmp_key] = tmp_val
            tmp_key = nil
            tmp_val = ""
          end

          tmp_key = md[1]
          tmp_val = md[2]
        else
          tmp_val += line
        end
      end

      if tmp_key
        h[tmp_key] = tmp_val
        tmp_key = nil
        tmp_val = ""
      end

      h
    end
  end
end
