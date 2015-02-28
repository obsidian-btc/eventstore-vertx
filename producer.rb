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

start_time = Time.now

500.times do
  event_type = "TestEvent"
  data = JSON.generate({ at: Time.now.to_i, foo: "bar" })
  event = eventstore.new_event(event_type, data)
  # puts ">#{stream}\t\t#{event.inspect}"
  prom = eventstore.write_events(stream, event)
  prom.sync
end

p "Seeded events in #{Time.now - start_time} seconds"
