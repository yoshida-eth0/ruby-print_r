#!/usr/bin/ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../lib"

require 'print_r'

text = "Array
(
    [id] => 123
    [hello] => world
    [status] => Array
        (
            [test1] => aaaa
            [test2] => aaaa
            [test3] => aaaa
            [test4] => Array
                (
                    [key1] => bbbb
                    [key2] => bbbb
                    [key3] => bbbb
                )

        )

    [obj] => stdClass Object
        (
            [aa] => vv
        )

)
"
obj = PrintR.parse(text)
p obj
