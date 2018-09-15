
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

The Technology Addon for Influxdata Telegraf provides indexing time parsing definitions and pre-built panels to ingest Telegraf metrics to Splunk metric store.

The TA is only required at indexing time (Indexers and Intermediate Heavy Forwarders) if you ingest metrics over TCP inputs or Kafka.

Starting Telegraf Version 1.8, you can use a builtin http outputs that sends metrics to the HTTP Events Collector.

The TA is only required on search heads if you intend to use pre-built panels.


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

### The installation of Telegraf is really straightforward, consult:

- https://github.com/influxdata/telegraf

### A minimal configuration to monitor Operating System metrics:

- https://docs.influxdata.com/chronograf/latest/guides/using-precreated-dashboards/#system

The output configuration depends on the deployment you choose to use to ingest metrics in Splunk, consult the next sections.

### Example of a minimal telegraf.conf configuration that monitors Operating System metrics

```

# Read metrics about cpu usage
[[inputs.cpu]]
  ## Whether to report per-cpu stats or not
  percpu = true
  ## Whether to report total system cpu stats or not
  totalcpu = true
  ## If true, collect raw CPU time metrics.
  collect_cpu_time = false
  ## If true, compute and report the sum of all non-idle CPU states.
  report_active = false

# Read metrics about disk usage by mount point
[[inputs.disk]]
  ## By default stats will be gathered for all mount points.
  ## Set mount_points will restrict the stats to only the specified mount points.
  # mount_points = ["/"]

  ## Ignore mount points by filesystem type.
  ignore_fs = ["tmpfs", "devtmpfs", "devfs"]

# Read metrics about disk IO by device
[[inputs.diskio]]
  ## By default, telegraf will gather stats for all devices including
  ## disk partitions.
  ## Setting devices will restrict the stats to the specified devices.
  # devices = ["sda", "sdb", "vd*"]
  ## Uncomment the following line if you need disk serial numbers.
  # skip_serial_number = false
  #
  ## On systems which support it, device metadata can be added in the form of
  ## tags.
  ## Currently only Linux is supported via udev properties. You can view
  ## available properties for a device by running:
  ## 'udevadm info -q property -n /dev/sda'
  # device_tags = ["ID_FS_TYPE", "ID_FS_USAGE"]
  #
  ## Using the same metadata source as device_tags, you can also customize the
  ## name of the device via templates.
  ## The 'name_templates' parameter is a list of templates to try and apply to
  ## the device. The template may contain variables in the form of '$PROPERTY' or
  ## '${PROPERTY}'. The first template which does not contain any variables not
  ## present for the device is used as the device name tag.
  ## The typical use case is for LVM volumes, to get the VG/LV name instead of
  ## the near-meaningless DM-0 name.
  # name_templates = ["$ID_FS_LABEL","$DM_VG_NAME/$DM_LV_NAME"]

# Get kernel statistics from /proc/stat
[[inputs.kernel]]
  # no configuration


# Read metrics about memory usage
[[inputs.mem]]
  # no configuration


# Get the number of processes and group them by status
[[inputs.processes]]
  # no configuration


# Read metrics about swap memory usage
[[inputs.swap]]
  # no configuration


# Read metrics about system load & uptime
[[inputs.system]]
  # no configuration

# # Read metrics about network interface usage
[[inputs.net]]
#   ## By default, telegraf gathers stats from any up interface (excluding loopback)
#   ## Setting interfaces will tell it to gather these explicit interfaces,
#   ## regardless of status.
#   ##
#   # interfaces = ["eth0"]
#   ##
#   ## On linux systems telegraf also collects protocol stats.
#   ## Setting ignore_protocol_stats to true will skip reporting of protocol metrics.
#   ##
#   # ignore_protocol_stats = false
#   ##

# # Read TCP metrics such as established, time wait and sockets counts.
[[inputs.netstat]]
#   # no configuration

# # Monitor process cpu and memory usage
[[inputs.procstat]]
#   ## PID file to monitor process
#   pid_file = "/var/run/nginx.pid"
#   ## executable name (ie, pgrep <exe>)
#   # exe = "nginx"
#   ## pattern as argument for pgrep (ie, pgrep -f <pattern>)
#   # pattern = "nginx"
#   ## user as argument for pgrep (ie, pgrep -u <user>)
    user = "guilhem"
#   ## Systemd unit name
#   # systemd_unit = "nginx.service"
#   ## CGroup name or path
#   # cgroup = "systemd/system.slice/nginx.service"
#
#   ## override for process_name
#   ## This is optional; default is sourced from /proc/<pid>/status
#   # process_name = "bar"
#
#   ## Field name prefix
#   # prefix = ""
#
#   ## Add PID as a tag instead of a field; useful to differentiate between
#   ## processes whose tags are otherwise the same.  Can create a large number
#   ## of series, use judiciously.
#   # pid_tag = false
#
#   ## Method to use when finding process IDs.  Can be one of 'pgrep', or
#   ## 'native'.  The pgrep finder calls the pgrep executable in the PATH while
#   ## the native finder performs the search directly in a manor dependent on the
#   ## platform.  Default is 'pgrep'
#   # pid_finder = "pgrep"

```

```
 _   _ _____ _____ ____    _____                 _
| | | |_   _|_   _|  _ \  | ____|_   _____ _ __ | |_ ___
| |_| | | |   | | | |_) | |  _| \ \ / / _ \ '_ \| __/ __|
|  _  | | |   | | |  __/  | |___ \ V /  __/ | | | |_\__ \
|_| |_| |_|   |_| |_|     |_____| \_/ \___|_| |_|\__|___/

  ____      _ _           _                __  _   _ _____ ____  __
 / ___|___ | | | ___  ___| |_ ___  _ __   / / | | | | ____/ ___| \ \
| |   / _ \| | |/ _ \/ __| __/ _ \| '__| | |  | |_| |  _|| |      | |
| |__| (_) | | |  __/ (__| || (_) | |    | |  |  _  | |__| |___   | |
 \____\___/|_|_|\___|\___|\__\___/|_|    | |  |_| |_|_____\____|  | |
                                          \_\                    /_/

```

## Splunk deployment with HEC (available with Telegraf starting version 1.8)

Telegraf agents --> HTTP over SSL --> Splunk HEC inputs

With Telegraf starting version 1.8, you can send metrics directly from Telegraf to HTTP Events Collector using the
excellent serializer leveraging the http Telegraf output.

This is extremely simple, scalable and reliable.

### Example of an HEC input definition:

```
inputs.conf

[http://Telegraf]
disabled = 0
index = telegraf
indexes = telegraf
token = c386d4c8-8b50-4178-be76-508dca2f19e2
```

Telegraf configuration:

### The Telegraf configuration is really simple and relies on defining your ouput:

Example:

```
[[outputs.http]]
   ## URL is the address to send metrics to
   url = "https://mysplunk.domain.com:8088/services/collector"
    ## Timeout for HTTP message
   # timeout = "5s"
    ## Optional TLS Config
   # tls_ca = "/etc/telegraf/ca.pem"
   # tls_cert = "/etc/telegraf/cert.pem"
   # tls_key = "/etc/telegraf/key.pem"
   ## Use TLS but skip chain & host verification
   insecure_skip_verify = true
    ## Data format to output.
   ## Each data format has it's own unique set of configuration options, read
   ## more about them here:
   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
   data_format = "splunkmetric"
    ## Provides time, index, source overrides for the HEC
   splunkmetric_hec_routing = true
    ## Additional HTTP headers
    [outputs.http.headers]
   # Should be set manually to "application/json" for json data_format
      Content-Type = "application/json"
      Authorization = "Splunk c386d4c8-8b50-4178-be76-508dca2f19e2"
      X-Splunk-Request-Channel = "c386d4c8-8b50-4178-be76-508dca2f19e2"
```

Push this configuration to your Telegraf agents, et voila.

Check data availability in Splunk:

```
| mstats values(_dims) as dimensions values(metric_name) as metric_name where index=telegraf metric_name=*
```

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

### Example of a tcp input definition:

```
inputs.conf

[tcp://2003]
connection_host = dns
index = telegraf
sourcetype = tcp:telegraf:graphite
```

Telegraf configuration:

### The Telegraf configuration is really simple and relies on defining your ouput:

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