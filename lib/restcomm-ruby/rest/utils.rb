module Restcomm
  module REST
    module Utils

      def restify(something)
        return key_map(something, :restify) if something.is_a? Hash
        string = something.to_s
        string.split('_').map do |string_part|
          string_part[0,1].capitalize + string_part[1..-1]
        end.join
      end

      def derestify(something)
        return key_map(something, :derestify) if something.is_a? Hash
        string = something.to_s
        string = string[0,1].downcase + string[1..-1]
        string.gsub(/[A-Z][a-z]*/) { |s| "_#{s.downcase}" }
      end

      protected

      def resource(*resources)
        custom_resource_names = { sms: 'SMS', sip: 'SIP' }
        resources.each do |r|
          resource = restify r
          relative_path = custom_resource_names.fetch(r, resource)
          path = "#{@path}/#{relative_path}"
          enclosing_module = if @submodule == nil
            Restcomm::REST
          else
            Restcomm::REST.const_get(@submodule)
          end
          resource_class = enclosing_module.const_get resource
          instance_variable_set("@#{r}", resource_class.new(path, @client))
        end
        self.class.instance_eval { attr_reader *resources }
      end

      private

      def key_map(something, method)
        something = something.to_a.flat_map do |pair|
          [send(method, pair[0]).to_sym, pair[1]]
        end
        Hash[*something]
      end
    end
  end
end
