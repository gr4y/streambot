module StreamBot
  # Filter
  class Filter
    USER = "user"
    LANGUAGE = "lang"
    CONTENT = "content"

    def initialize(type, value)
      @type=type
      @value=value
    end

    def filter?(status)
      case @type
        when USER then
          status.user.screen_name.eql?(@value)
        when CONTENT then
          status.text.include?(@value)
        when LANGUAGE then
          status.lang.eql?(@value)
      end
    end
  end
end