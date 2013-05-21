#!/usr/bin/ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../lib"

require 'print_r'
require 'pp'

text = <<EOF
Hash Object
(
    [val] => 123
    [nest] => Hash Object
        (
            [val] => 123
            [nest] => Hash Object
 *RECURSION*
        )

)
EOF

obj = PrintR.parse(text)
pp obj
