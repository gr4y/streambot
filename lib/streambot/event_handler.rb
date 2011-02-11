module StreamBot
  module EventHandler

    # register an event with the given name
    def event(name)
      register_event(name)
    end

    # register several events with the given names
    def events(* names)
      names.each do |name|
        event(name)
      end
    end
    
    private
    # the real event registration
    def register_event(name)
      class_eval do
        define_event_method(name);
      end
    end
    
    def define_event_method(name)
      variable =:"@#{name}"
      define_method(name) do
        event = instance_variable_get(variable)
        if event == nil
          event = StreamBot::Event.new(name)
          instance_variable_set(variable, event)
        end
        event
      end
    end
  end
end