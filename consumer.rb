require 'bundler'
Bundler.setup

require 'vertx'
require 'eventstore'
require 'json'

config = Vertx.config
p stream = config['stream']

eventstore = Eventstore.new("localhost", 1113)
eventstore.on_error { |error| Thread.main.raise(error) }
eventstore


sub = eventstore.new_subscription(stream)
sub.on_event { |event| p event }
sub.on_error { |error| fail error.inspect }
sub.start
