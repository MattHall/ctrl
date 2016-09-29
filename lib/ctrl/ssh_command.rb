module Ctrl
  class SshCommand
    include Virtus::Model

    NAT_USER = ENV['CTRL_SSH_NAT_USER'] || 'ec2_user'
    SSH_USER = ENV['CTRL_SSH_USER'] || 'ubuntu'

    attribute :nat_instance
    attribute :target_instance

    def target_is_nat?
      nat_instance.instance_id == target_instance.instance_id
    end

    def direct_cmd
      "ssh -A #{SSH_USER}@#{nat_instance.public_ip_address}"
    end

    def proxied_cmd
      "ssh -A -t #{CTRL_SSH_NAT_USER}@#{nat_instance.public_ip_address} \"ssh #{CTRL_SSH_USER}@#{target_instance.private_ip_address}\""
    end

    def to_s
      return direct_cmd if target_is_nat?
      proxied_cmd
    end
  end
end
