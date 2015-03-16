module Restcomm
  module REST
    class Local < ListResource
      def initialize(path, client)
        @path, @client = path, client
        @instance_class = Restcomm::REST::AvailablePhoneNumber
        @list_key, @instance_id_key = 'available_phone_numbers', 'sid'
      end
    end
  end
end
