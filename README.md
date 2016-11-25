# RabbitMQ turnkey image

## Scope

This image aims at providing a turnkey image for testing RabbitMQ related projects.

The goal of this image is to offer a convenient way to locally test, start and dispose of a RabbitMQ cluster.
It is not written with production in mind: we kept the changes minimal and don't focus on performance nor security in this image.

The version used might not be the latest one, our goal is to use this image to test with the same version as the one used by CloudAMQP.


## What's in it

RabbitMQ version: 3.5.7 or 3.6.6
Enabled-plugins: The plugins enabled by default are still there, and this image add and enables the **management** plugin and the **delayed message** plugin.

Here's the complete list of the plugins enabled:
- rabbitmq_management
- amqp_client
- rabbitmq_delayed_message_exchange
- rabbitmq_management_agent
- rabbitmq_shovel
- rabbitmq_shovel_management
- rabbitmq_web_dispatch
- webmachine
- mochiweb


## Build it

    docker build . -t smooch/rabbitmq:3.5.7 -f Dockerfile.3.5.7
    docker build . -t smooch/rabbitmq:3.6.6 -f Dockerfile.3.6.6

## Use it

Baked-in settings, using docker-compose:

    docker-compose up


Manually if you want to have any other ports, volumes, ....

    docker run -it --rm --hostname local-rabbit -p 15672:15672 -p 5672:5672 smooch/rabbitmq:3.6.6


If you don't have yet any code to test it, you can already access the management UI to check that your RabbitMQ service is running.


## Open management plugin

The management plugin is exposed using the default port: [http://localhost:15672/#/](http://guest:guest@localhost:15672/)
The management REST API is exposed there as well.


## See the queues, ready messages and unacknowledged messages

When testing/debugging, you might want to call `rabbitmqctl`. You could simply call it through `docker exec`. 

This sample, run in your host terminal, will refresh every seconds the list of the queues, with for each queue the numbers of ready messages (messages in the queue waiting to be consumed) and unacknowledged messages (messages delivered to a subscriber, which haven't yet acknowledge this message).
 
```
watch -n 1 -c -d docker exec -it `docker ps | grep smoochrabbitmq | awk '{print $1 }'` rabbitmqctl list_queues name messages_ready messages_unacknowledged
```



## Add the visualisation tab to the management API
If you want to have a look at your current topology, the Visualizer extension of the management UI could be helpful. 
In order to enable it, you can just turn it on live by running

```
docker exec -it `docker ps | grep smoochrabbitmq | awk '{print $1 }'` rabbitmq-plugins enable rabbitmq_management_visualiser
```