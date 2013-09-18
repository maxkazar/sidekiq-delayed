module Sidekiq
  module Delayed
    class Proxy
      def initialize(target, queue, async)
        @queue = queue
        @target = target
        @async = async
      end

      def method_missing(*args)
        Performer.create @target, @queue, *args
      end
    end
  end
end