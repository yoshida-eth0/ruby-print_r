require 'print_r'

class Object
  def print_r
    PrintR.generate(self)
  end
end
