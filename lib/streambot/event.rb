module StreamBot
  # event class
  class Event
    attr_reader :name

    def initialize(name)
      LOG.debug "initialize: #{name}"
      @name = name
    end

    def receive(method=nil, & block)
      LOG.debug "receive: #{self.name}" 
      @handler = method if !method.nil?
      @handler = block if !block.nil?
    end

    def trigger(* args)
      LOG.debug "trigger: #{self.name}"
      @handler.call(*args) if !@handler.nil?
    end
  end
end