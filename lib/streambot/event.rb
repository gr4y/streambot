module StreamBot
  # event class
  class Event
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def handle(method=nil, & block)
      @handler = method if method
      @handler = block if block
    end

    def trigger(* args)
      @handler.call(* args) if !@handler.nil?
    end
  end
end