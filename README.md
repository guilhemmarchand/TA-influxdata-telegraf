
```
 ___        __ _               _       _
|_ _|_ __  / _| |_   ___  ____| | __ _| |_ __ _ 
 | || '_ \| |_| | | | \ \/ / _` |/ _` | __/ _` |
 | || | | |  _| | |_| |>  < (_| | (_| | || (_| |
|___|_| |_|_| |_|\__,_/_/\_\__,_|\__,_|\__\__,_|
                                                
 _____    _                       __ 
|_   _|__| | ___  __ _ _ __ __ _ / _|
  | |/ _ \ |/ _ \/ _` | '__/ _` | |_ 
  | |  __/ |  __/ (_| | | | (_| |  _|
  |_|\___|_|\___|\__, |_|  \__,_|_|  
                 |___/

```

## The plugin-driven server agent for collecting and reporting metrics by Influxdata !


```
 _____    _                       __
|_   _|__| | ___  __ _ _ __ __ _ / _|
  | |/ _ \ |/ _ \/ _` | '__/ _` | |_
  | |  __/ |  __/ (_| | | | (_| |  _|
  |_|\___|_|\___|\__, |_|  \__,_|_|
                 |___/
 _           _        _ _       _   _
(_)_ __  ___| |_ __ _| | | __ _| |_(_) ___  _ __
| | '_ \/ __| __/ _` | | |/ _` | __| |/ _ \| '_ \
| | | | \__ \ || (_| | | | (_| | |_| | (_) | | | |
|_|_| |_|___/\__\__,_|_|_|\__,_|\__|_|\___/|_| |_|

```

## Telegraf installation, configuration and start

The installation of Telegraf is really straightforward, consult:

https://github.com/influxdata/telegraf

A minimal configuration to monitor Operating System metrics:

- https://docs.influxdata.com/chronograf/latest/guides/using-precreated-dashboards/#system

The output configuration depends on the deployment you choose to use to ingest metrics in Splunk, consult the next sections.

```
 _____ ____ ____       __  _____ ____ ____      ____ ____  _
|_   _/ ___|  _ \     / / |_   _/ ___|  _ \    / ___/ ___|| |
  | || |   | |_) |   / /    | || |   | |_) |___\___ \___ \| |
  | || |___|  __/   / /     | || |___|  __/_____|__) |__) | |___
  |_| \____|_|     /_/      |_| \____|_|       |____/____/|_____|

 _                   _
(_)_ __  _ __  _   _| |_ ___
| | '_ \| '_ \| | | | __/ __|
| | | | | |_) | |_| | |_\__ \
|_|_| |_| .__/ \__,_|\__|___/
        |_|

```

## Splunk deployment with TCP inputs

The deployment is very simple and can be described as:

Telegraf agents --> TCP or TCP over SSL --> Splunk TCP inputs

In addition and to provide resiliency, it is fairly simple to add a load balancer in front of Splunk, such that you service continues to ingest metrics depending on
Splunk components availability. (HAProxy, Nginx, F5, whatsoever...)

The data output format used by Telegraf agents is the "Graphite" format with tag support enable.
This is simple, beautiful, accurate and allows the management of any number of dimensions.

Example of a tcp input definition:

```
inputs.conf

[tcp://2003]
connection_host = dns
index = telegraf
sourcetype = tcp:telegraf:graphite
```

Telegraf configuration:

The Telegraf configuration is really simple and relies on defining your ouput:

Example:

```
[[outputs.graphite]]
  ## TCP endpoint for your graphite instance.
  ## If multiple endpoints are configured, the output will be load balanced.
  ## Only one of the endpoints will be written to with each iteration.
  servers = ["mysplunk.domain.com:2003"]
  ## Prefix metrics name
  prefix = ""
  ## Graphite output template
  ## see https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
  # template = "host.tags.measurement.field"

  ## Enable Graphite tags support
  graphite_tag_support = true

  ## timeout in seconds for the write connection to graphite
  timeout = 2
```

Push this configuration to your Telegraf agents, et voila.

Check data availability in Splunk:

```
| mstats values(_dims) as dimensions values(metric_name) as metric_name where index=telegraf metric_name=*
```

```
 _  __    _    _  _______ _      _                       _   _
| |/ /   / \  | |/ /  ___/ \    (_)_ __   __ _  ___  ___| |_(_) ___  _ __
| ' /   / _ \ | ' /| |_ / _ \   | | '_ \ / _` |/ _ \/ __| __| |/ _ \| '_ \
| . \  / ___ \| . \|  _/ ___ \  | | | | | (_| |  __/\__ \ |_| | (_) | | | |
|_|\_\/_/   \_\_|\_\_|/_/   \_\ |_|_| |_|\__, |\___||___/\__|_|\___/|_| |_|
                                         |___/
```

## Splunk deployment with Kafka

If you are using Kafka, or consider using it, producing Telegraf metrics to Kafka makes a lot of sense.

First, Telegraf has a native output plugin that produces to a Kafka topic, Telegraf will send the metrics directly to one or more
Kafka brokers providing scaling and resiliency.

Then, Splunk becomes one consumer of the metrics using the scalable and resilient Kafka connect infrastructure and the Splunk Kafka connect sink connector.
By using Kafka as the mainstream for your metrics, you preserve the possibility of having multiple technologies consuming these data in addition with Splunk, while
implementing a massively scalable and resilient environment.

On the final step that streams data to Splunk, the Kafka sink connector for Splunk sends data to Splunk HEC, which makes it resilient, scalable and eligible to all
Splunk on-premise or Splunk Cloud platforms easily.

The deployment with Kafka can be described the following way:

Telegraf agents --> Kafka brokers <-- Kafka connect running Splunk sink connector --> Splunk HTTP Event Collector (HEC)

Configuring Kafka connect:

- The Kafka connect properties needs to use the "String" converter, the following example start Kafka connect with the relevant configuration:

```
# connect-distributed.properties

# These are defaults. This file just demonstrates how to override some settings.
bootstrap.servers=kafka-1:9092,kafka-2:9092,kafka-3:9092
key.converter=org.apache.kafka.connect.storage.StringConverter
value.converter=org.apache.kafka.connect.storage.StringConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false
internal.key.converter=org.apache.kafka.connect.json.JsonConverter
internal.value.converter=org.apache.kafka.connect.json.JsonConverter
internal.key.converter.schemas.enable=false
internal.value.converter.schemas.enable=false
# Flush much faster (10s) than normal, which is useful for testing/debugging
offset.flush.interval.ms=10000
plugin.path=/etc/kafka-connect/jars
group.id=kafka-connect-splunk-hec-sink
config.storage.topic=__kafka-connect-splunk-task-configs
config.storage.replication.factor=3
offset.storage.topic=__kafka-connect-splunk-offsets
offset.storage.replication.factor=3
offset.storage.partitions=25
status.storage.topic=__kafka-connect-splunk-statuses
status.storage.replication.factor=3
status.storage.partitions=5
# These are provided to inform the user about the presence of the REST host and port configs 
# Hostname & Port for the REST API to listen on. If this is set, it will bind to the interface used to listen to requests.
#rest.host.name=
rest.port=8082
# The Hostname & Port that will be given out to other workers to connect to i.e. URLs that are routable from other servers.
# rest.advertised.host.name=kafka-connect-1
```

Apply the following command against Kafka connect running the Splunk Kafka sink connector (https://splunkbase.splunk.com/app/3862)

- replace <ip address or host> by the IP address or the host name of the Kafla connect node, if you run the command locally, simply use localhost
- replace the port if required (default is 8082)
- replace the HEC token
- replace the HEC destination
- adapt any other configuration item up to your needs

```
curl localhost:8082/connectors -X POST -H "Content-Type: application/json" -d '{
"name": "kafka-connect-telegraf",
"config": {
"connector.class": "com.splunk.kafka.connect.SplunkSinkConnector",
"tasks.max": "3",
"topics":"telegraf",
"splunk.indexes": "telegraf",
"splunk.sourcetypes": "kafka:telegraf:graphite",
"splunk.hec.uri": "https://myhecinput.splunk.com:8088",
"splunk.hec.token": "fd96ffb6-fb3e-43aa-9e8b-de911356443f",
"splunk.hec.raw": "true",
"splunk.hec.ack.enabled": "true",
"splunk.hec.ack.poll.interval": "10",
"splunk.hec.ack.poll.threads": "2",
"splunk.hec.ssl.validate.certs": "false",
"splunk.hec.http.keepalive": "true",
"splunk.hec.max.http.connection.per.channel": "4",
"splunk.hec.total.channels": "8",
"splunk.hec.max.batch.size": "1000000",
"splunk.hec.threads": "2",
"splunk.hec.event.timeout": "300",
"splunk.hec.socket.timeout": "120",
"splunk.hec.track.data": "true"
}
}'
```

### telegraf output configuration:

Configure your Telegraf agents to send data directly to the Kafka broker in graphite format with tag support:

```
[[outputs.kafka]]
  ## URLs of kafka brokers
  brokers = ["kafka-1:19092","kafka-2:29092","kafka-3:39092"]
  ## Kafka topic for producer messages
  topic = "telegraf"
  data_format = "graphite"
  graphite_tag_support = true
```

Et voila. Congratulations, you have built a massively scalable, distributable, open and resilient metric collection infrastructure.

Check data availability in Splunk:

```
| mstats values(_dims) as dimensions values(metric_name) as metric_name where index=telegraf metric_name=*

```