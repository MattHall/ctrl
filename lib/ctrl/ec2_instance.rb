module Ctrl
  class Ec2Instance
    include Virtus::Model

    attribute :private_ip_address, String
    attribute :public_ip_address, String
    attribute :name, String
    attribute :environment, String
    attribute :state, String
    attribute :instance_id, String

    def self.from_instance(_instance)
      new.tap do |i|
        i.private_ip_address = _instance.private_ip_address
        i.name = _instance.tags.select {|e| e.key == 'Name'}.first&.value
        i.environment = _instance.tags.select {|e| e.key == 'Environment'}.first&.value
        i.state = _instance.state.name
        i.instance_id = _instance.instance_id
        i.public_ip_address = _instance.public_ip_address
      end
    end

    def to_s
      "%10s %20s %15s %10s %16s %16s" % [environment, name, state, instance_id, private_ip_address, public_ip_address]
    end
  end
end
