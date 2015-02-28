require 'vertx'
require 'securerandom'

config = {
  stream: "test-#{SecureRandom.uuid}"
}

Vertx.deploy_worker_verticle('producer.rb', config)
Vertx.deploy_worker_verticle('consumer.rb', config)