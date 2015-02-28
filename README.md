# eventstore-vertx
This is a simple Ruby EventStore producer/consumer example running in Vert.X

Currently, this is highly dependent on the load order of the verticles.  If the consumer starts up before the producer has finished producing, the consumer will blow up because it seems to be picknig up malformed messages from the EventStore.
