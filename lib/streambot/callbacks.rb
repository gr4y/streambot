module StreamBot
  module Callbacks    
    def callback(name)
      register_callback(name)
    end

    def callbacks(* names)
      names.each do |name|
        register_callback(name)
      end
    end

    def is_registered?(name)      
      @callbacks.include?(name)
    end

    def register_callback(name)
      class_eval <<-EOF
          def #{name} (*args,&block)
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