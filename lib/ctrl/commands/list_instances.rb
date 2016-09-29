module Ctrl
  module Commands
    class ListInstances < Base
      attribute :env_name, String
      attribute :instance_name, String
      attribute :instance_state, String

      def filters
        @filters ||= [
          { name: 'tag:Environment', values: [env_name].compact },
          { name: 'tag:Name', values: [instance_name].compact },
          { name: 'instance-state-name', values: [instance_state].compact }
        ].delete_if {|e| e[:values].empty?}
      end

      def scope
        filters.any? ? client.instances(filters: filters) : client.instances
      end

      def instances
        @instances ||= scope.inject([]) do |a, e|
          a << Ctrl::Ec2Instance.from_instance(e)
        end
      end

      def perform
        puts "Instances"
        puts instances.map(&:to_s)
      end
    end
  end
end
