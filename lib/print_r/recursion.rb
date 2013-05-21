module PrintR
  class Recursion < RuntimeError
    attr_reader :object_type

    def initialize(error_message=nil)
      @object_type = error_message
      super(error_message)
    end

    def to_s
      "#{object_type} *RECURSION*"
    end
  end
end
