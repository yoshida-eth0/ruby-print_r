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
      tab = "    " * indent
      md = str.match(/^(?:Array|.*? Object)\n#{tab}\(\n(.+)#{tab}\)$/m)
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
      tab = "    " * indent
      h = {}
      key = nil
      val = ""
      lines.each do |line|
        md = line.match(/^#{tab}\[([^\]]+)\] => (.*)/)
        if md
          if key
            h[key] = val
            key = nil
            val = ""
          end

          key = md[1]
          val = md[2]
        else
          val += line
        end
      end

      if key
        h[key] = val
        key = nil
        val = ""
      end

      h
    end
  end
end
