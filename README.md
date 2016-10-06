# RabbitMQ turnkey image

## Scope

This image aims at providing a turnkey image for testing RabbitMQ related projects.

The goal of this image is to offer a convenient way to locally test, start and dispose of a RabbitMQ cluster.
It is not written with production in mind: we kept the changes minimal and don't focus on performance nor security in this image.

The version used might not be the latest one, our goal is to use this image to test with the same version as the one exposed by CloudAMQP (3.5.7).


## What's in it

RabbitMQ version: 3.5.7
Enabled-plugins: The plugins enabled by default are still there, and this image add and enables the **management** plugin and the **delayed message** plugin.

Here's the complete list of the plugins enabled:
- rabbitmq_management
- amqp_client
- rabbitmq_delayed_message_exchange
- rabbitmq_management_agent
- rabbitmq_web_dispatch
- webmachine
- mochiweb


## Use it

Baked-in settings, using docker-compose:

    docker-compose up


Manually if you want to have any other ports, volumes, ....

    docker run -it --rm --hostname local-rabbit -p 15672:15672 -p 5672:5672 smooch/rabbitmq


If you don't have yet any code to test it, you can already access the management UI to check that your RabbitMQ service is running.


## Open management plugin

The management plugin is exposed using the default port: [http://localhost:15672/#/](http://guest:guest@localhost:15672/)
The management REST API, is exposed there as well.
