module Sidekiq
  module Delayed
    class Performer
      include Sidekiq::Worker

      def perform(yml)
        options = YAML.load yml
        model = options[:class].constantize.unscoped.where(id: options[:id]).first
        return unless model.present?

        model.scope = options.delete(:scope)
        model.timestamp = options.delete(:timestamp)

        model.send options[:method], *options[:args]
      end

      class << self
        def create(target, queue, *args)
          options = { class: self, args: enqueue_payload(target, *args) }
          options[:queue] = queue if queue
          client_push options
        end

        def enqueue_payload(target, *args)
          method = args.shift()
          options = {
            class: target.class.to_s,
            id: target.id.to_s,
            method: method,
            args: args,
          }
          options[:scope] = target.scope && !target.scope.is_a?(String) ? target.scope.id.to_s : target.scope
          options[:timestamp] = target.timestamp if target.respond_to? :timestamp

          [YAML.dump(options)]
        end
      end
    end
  end
end