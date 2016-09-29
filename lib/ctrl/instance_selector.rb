module Ctrl
  class InstanceSelector
    include Virtus::Model

    attribute :instances, Array[Ec2Instance]

    def display_options
      puts "Instances"
      instances.each_with_index do |instance, i|
        puts ("%2d %s" % [i + 1, instance.to_s])
      end
      puts "\nPlease select an instance"
    end

    def selection
      return @selection if @selection

      loop do
        display_options
        selected_index = Readline.readline(">> ")
        @selection = instances[selected_index.to_i - 1]
        break if selected_index.to_i > 0 && @selection
      end

      @selection
    end

    def perform
      instances.size == 1 ? instances.first : selection
    end
  end
end
