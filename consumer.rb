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

received = 0

def do_work_that_blocks_the_event_loop(arg)
  p arg
  Vertx.exit if arg >= 500
end

sub = eventstore.new_catchup_subscription(stream, -1)
sub.on_event { |event| received += 1 ; do_work_that_blocks_the_event_loop(received)}
sub.on_error { |error| p error.inspect }

Vertx.set_timer(5_000) do
  p "Timeout reached, starting the subscriptions"
  sub.start
end