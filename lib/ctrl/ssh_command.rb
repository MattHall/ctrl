module Ctrl
  class SshCommand
    include Virtus::Model

    NAT_USER = ENV['CTRL_SSH_NAT_USER'] || 'ec2_user'
    SSH_USER = ENV['CTRL_SSH_USER'] || 'ubuntu'

    attribute :nat_instance
    attribute :target_instance

    def target_is_public?
      target_instance.public_ip_address.to_s != ""
    end

    def direct_cmd
      "ssh -A #{SSH_USER}@#{target_instance.public_ip_address}"
    end

    def proxied_cmd
      "ssh -A -t #{NAT_USER}@#{nat_instance.public_ip_address} \"ssh #{SSH_USER}@#{target_instance.private_ip_address}\""
    end

    def to_s
      return direct_cmd if target_is_public?
      proxied_cmd
    end
  end
end
