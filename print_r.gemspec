# -*- encoding: utf-8 -*-

require './lib/print_r/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Yoshida Tetsuya"]
  gem.email         = ["yoshida.eth0@gmail.com"]
  gem.description   = %q{This is a print_r() implementation.}
  gem.summary       = %q{This is a print_r() implementation.}
  gem.homepage      = %q{https://github.com/yoshida-eth0/ruby-print_r}

  gem.files         = `git ls-files`.split($\).delete_if{|x| x.match(/^example/)}
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "print_r"
  gem.require_paths = ["lib"]
  gem.version       = PrintR::VERSION
end
