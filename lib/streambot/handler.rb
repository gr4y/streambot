module StreamBot
  # some important code for the communication wrappers
  class Handler
    # parse an response 
    def parse_response(object)
      LOG.debug("response is #{object}")
      case object
        when ::Net::HTTPUnauthorized
          ::File.delete(ACCESS_TOKEN)
          raise 'user revoked oauth connection'
        when ::Net::HTTPOK then
          object.body
      end
    end
  end
end