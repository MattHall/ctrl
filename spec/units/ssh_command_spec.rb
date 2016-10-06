require 'spec_helper'

describe Ctrl::SshCommand do
  context '#to_s' do
    let(:nat_instance) { double(:nat_instance, public_ip_address: '192.168.0.1') }

    subject { described_class.new(nat_instance: nat_instance, target_instance: instance).to_s }

    context 'when the target has a public ip address' do
      let(:instance) { double(:instance, public_ip_address: '192.168.0.2') }

      it 'should return a direct ssh command' do
        expect(subject).to eql("ssh -A ubuntu@192.168.0.2")
      end
    end

    context 'when the target only has a private ip address' do
      let(:instance) { double(:instance, public_ip_address: nil, private_ip_address: '10.0.0.1') }

      it 'should return a proxied ssh command' do
        expect(subject).to eql("ssh -A -t ec2_user@192.168.0.1 \"ssh ubuntu@10.0.0.1\"")
      end
    end
  end
end
