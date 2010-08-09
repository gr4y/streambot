module StreamBot
  class Callbacks
    def callback(name)
      register_callback(name, &block)
    end

    private
    # register an callback method 
    def register_callback(name, &block)
      class_eval <<-EOF
        def #{name}(*args,&block)
          if block
            @#{name} = block
          elsif @#{name}
            @#{name}.call(*args)
          end
        end
      EOF
    end
  end
end