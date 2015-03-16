module Restcomm
  module REST
    class FeedbackSummary < ListResource
      def initialize(path, client)
        @path, @client = path, client
        @instance_class = Restcomm::REST::FeedbackSummaryInstance
        @list_key, @instance_id_key = 'feedback_summary', 'sid'
      end
    end

    class FeedbackSummaryInstance < InstanceResource; end
  end
end