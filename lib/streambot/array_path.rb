module StreamBot
  # ArrayPath like XPath, but for Arrays
  class ArrayPath
    
    def self.get_path(object, path)
      # raise "#{object} is not an array" if !object.is_a?(Array) 
      segments = path.chomp.split("/")
      segments.each do |segment|
        object = object[segment]
      end
      object
    end
        
  end
end