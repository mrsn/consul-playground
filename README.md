# consul-playground

### Cluster

	vagrant up

#### Learnings

1. Always specify a bind address (consul listens on the first private ip per default)
2. To join a cluster, there is no need to join a server (a join to any node is ok). Agents gossip with each other and propagate this information
3. Nodes in the same datacenter should be on a single LAN

##### Check cluster members (note this info is eventually consistent)
	consul members -detailed

##### Check cluster nodes (in a strongly consistent way)
	curl localhost:8500/v1/catalog/nodes

### Services

#### Querying Services over DNS API
	dig @127.0.0.1 -p 8600 web.service.consul

#### DNS API query to retrieve the entire address/port pair of a service as a SRV record
	dig @127.0.0.1 -p 8600 web.service.consul SRV

#### DNS API to filter all services by tags
	dig @127.0.0.1 -p 8600 rails.web.service.consul SRV

#### Quering Services over REST
	curl 'http://localhost:8500/v1/health/service/web'

#### Updating Service Definitions (/etc/consul.d/*)
Change configuration files and send a SIGHUP to the agent. This is safe and there is no downtime. 
	
