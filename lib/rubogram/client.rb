require 'faraday'
require 'faraday_middleware'
require 'json'

module Rubogram
  class Client
    def initialize token, adapter: Faraday.default_adapter, logging: true, raise_errors: true
      @faraday = Faraday.new "https://api.telegram.org/bot#{token}/" do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded

        # Logging
        faraday.response :logger, ::Logger.new(STDOUT), bodies: true if logging

        # Enabling error raising
        faraday.use Faraday::Response::RaiseError if raise_errors

        # Enabling json parser
        faraday.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/

        faraday.adapter adapter
      end
    end

    # Using method_missing for catching all the methods
    def method_missing method, *args, &block
      if args.size > 1
        raise ArgumentError.new "wrong number of arguments (#{args.size} for 0..1)"
      end

      args.push({}) if args.size == 0

      method = method.to_s.split('_').inject([]){ |b,e| b.push(b.empty? ? e : e.capitalize) }.join

      call(method, args[0])
    end

    # Call method from telegram api
    def call method, args = {}
      unless args.is_a? Hash
        raise ArgumentError.new "argument must be a Hash"
      end

      args.each_key do |key|
        if args[key].is_a?(Array) || args[key].is_a?(Hash)
          args[key] = JSON.dump(args[key])
        end
      end

      @faraday.post method, args
    end
  end
end
