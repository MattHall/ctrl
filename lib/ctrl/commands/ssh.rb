module Ctrl
  module Commands
    class Ssh < Base
      attribute :env_name, String
      attribute :instance_name, String

      def instances
        @instances ||= ListInstances.new(
          attributes.merge(instance_state: 'running')
        ).instances
      end

      def selected_instance
        @selected_instance ||= Ctrl::InstanceSelector.new(instances: instances).perform
      end

      def nat_instance
        @nat_instance ||= ListInstances.new(
          attributes.merge(instance_state: 'running', instance_name: 'nat')
        ).instances.first
      end

      def perform
        cmd = Ctrl::SshCommand.new(
          nat_instance: nat_instance,
          target_instance: selected_instance
        )

        exec cmd.to_s
      end
    end
  end
end
