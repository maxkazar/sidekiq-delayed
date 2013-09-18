require 'sidekiq/delayed/version'
require 'sidekiq/delayed/performer'
require 'sidekiq/delayed/proxy'

module Sidekiq
  module Delayed
    def delay(options = {})
      Proxy.new self, options[:queue], options[:async]
    end
  end
end

Object.send(:include, Sidekiq::Delayed)