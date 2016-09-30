# consul-playground

vagrant up

#### check cluster members (note this info is eventually consistent)
	`consul members -detailed`

#### check cluster nodes (in a strongly consistent way)
	`curl localhost:8500/v1/catalog/nodes`
