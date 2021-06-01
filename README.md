MariaDB Galera Cluster Arbitrator container

## Usage
`docker run -d --name galera-arbitrator -v /path_to/garb.cfg:/data/garb.cfg:ro neomediatech/galera-arbitrator`

## garb.cfg example file
```
# garbd config file
# daemon=1
address="gcomm://10.40.50.21,10.40.50.22,10.40.50.23"
group="MariaDB Galera Cluster"
# options="gmcast.segment=4;"
# log="/tmp/garb.log"
```
| Variable | Default | Description |
| -------- | ------- | ----------- |
| daemon | 0 | run garbd as daemon (don't do this if running on container) |
| address | - | list of Galera server to join to |
| group | - | Cluster group name (must match the value of wsrep_cluster_address variable in mysql config file, see below)|
| option | -| Same options set on other nodes of the cluster, if any |
| log | STDOUT if running in foreground, syslog if running as daemon | path to write logs |

## Galera sample config
create the file /etc/mysql/mariadb.conf.d/99-galera-custom.cnf and put this lines:
```
[galera]
wsrep_on                 = ON
wsrep_cluster_name       = "MariaDB Galera Cluster"
wsrep_provider           = /usr/lib/galera/libgalera_smm.so
wsrep_cluster_address    = "gcomm://10.4050.21,10.40.50.22"
binlog_format            = row
default_storage_engine   = InnoDB
innodb_autoinc_lock_mode = 2
bind-address             = 0.0.0.0
wsrep_node_address       = "10.40.50.21"
```
| Variable | Default | Description |
| -------- | ------- | ----------- |
| wsrep_cluster_name | - | Arbitrary cluster name, must match on every node |
| wsrep_cluster_address | - | list of cluster nodes. The first must be the primary node |
| wsrep_provider | - | path for the galera library. /usr/lib/galera/libgalera_smm.so for Ubuntu installations |
| wsrep_node_address | - | IP address for this node |


