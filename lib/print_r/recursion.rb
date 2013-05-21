module PrintR
  class Recursion
    attr_reader :object_type

    def initialize(object_type)
      @object_type = object_type
    end

    def to_s
      "#{object_type} *RECURSION*"
    end
  end
end
