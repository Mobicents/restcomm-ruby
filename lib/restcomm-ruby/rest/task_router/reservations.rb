module Restcomm
  module REST
    module TaskRouter
      class Reservations < Restcomm::REST::NextGenListResource; end
      class Reservation < InstanceResource; end
    end
  end
end
