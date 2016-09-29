module Ctrl
  module Commands
    class Base
      include Virtus::Model
      
      def self.perform(*opts)
        new(*opts).tap(&:perform)
      end

      def client
        @client ||= Aws::EC2::Resource.new
      end

      def perform
        fail 'override #perform'
      end
    end
  end
end
