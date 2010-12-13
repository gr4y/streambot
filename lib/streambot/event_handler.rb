module StreamBot
  module EventHandler

    def event(name)
      register_event(name)
    end

    def events(* names)
      names.each do |name|
        event(name)
      end
    end

    private
    def register_event(name)
      class_eval do
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
end