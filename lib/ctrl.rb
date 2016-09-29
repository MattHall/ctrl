require 'aws-sdk'
require 'virtus'
require 'readline'

require "ctrl/version"

require "ctrl/ec2_instance"
require "ctrl/instance_selector"
require "ctrl/ssh_command"

require "ctrl/commands/base"
require "ctrl/commands/list_instances"
require "ctrl/commands/ssh"

module Ctrl
end
