module Ctrl
  class SshCommand
    include Virtus::Model

    SSH_USER = 'deploy'

    attribute :nat_instance
    attribute :target_instance

    def target_is_nat?
      nat_instance.instance_id == target_instance.instance_id
    end

    def direct_cmd
      "ssh #{SSH_USER}@#{nat_instance.public_ip_address}"
    end

    def proxied_cmd
      "ssh -A -t #{SSH_USER}@#{nat_instance.public_ip_address} \"ssh #{target_instance.private_ip_address}\""
    end

    def to_s
      return direct_cmd if target_is_nat?
      proxied_cmd
    end
  end
end
