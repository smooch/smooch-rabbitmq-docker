FROM rabbitmq:3.5.7

ADD rabbitmq_delayed_message_exchange-0.0.1.ez /usr/lib/rabbitmq/lib/rabbitmq_server-3.5.7/plugins/rabbitmq_delayed_message_exchange-0.0.1.ez
RUN rabbitmq-plugins enable --offline rabbitmq_management  &&\
    rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# Management plugin ports
EXPOSE 15671 15672
