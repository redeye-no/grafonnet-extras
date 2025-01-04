 # grafonnet-extras

I can script a simple Grafana dashboard in less than 10 lines of code!

grafonnet-extras brings an OO-friendly coding interface to Grafana dashboards.

This completely removes the need to write native Grafonnet, or the underlying JSON.

## Have a look...

Import the extras library

	local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.0/main.libsonnet";

First, we create a plot (a query with hints on how to display the results)

	local usedMemoryPlot = 
		extras.sources.plot(
			ref = "mem_used",
			legend = "used", 
			query = "base_memory_usedHeap_bytes", 
			datasource = prometheus_uid
	);

In this plot, the query is targeted for the Grafana datasource whose ID is 'prometheus_uid'.
Now create panels that will render the plots in a dashboard

	local panels = [
		extras.panels.new(
			title = "Heap memory", 
			def = { type: "timeSeries" },
			queries = [ usedMemoryPlot ]
		) 
	];

Add the panels to a dashboard

	extras.dashboard.new(
		title = "First extras",
		uid = "52182d76-54c7-4b2f-b88c-4b41cf520e1d",
		panels = panels)

Tada! We have a dashboard,... in less than 10 lines!

More script samples in the examples folder in this repo.

## Requirements

grafonnet-extras requires Jsonnet to run.

## Getting started

grafonnet-extras works by processing input files written in Jsonnet form. The output is a JSON file that describes a Grafana dashboard.
The output files can then be uploaded into a Grafana instance, or deployed as provisioned dashboards.

### Installation

If Jsonnet is already installed, add grafonnet-extras with

	jb install github.com/redeye-no/grafonnet-extras/dist/11.0/@main

For container-savvy users, a grafonnet-extras image can be built using
(Assuming the root of this repo is the current working directory)

	nerdctl build -t grafonnet-extras:latest -f grafonnet-extras.imagefile .

The image is now ready to run, or it can be pushed to a private registry for inclusion in CI/CD pipelines.

### Running in Jsonnet

	jsonnet examples/1-simple-dash.jsonnet

### Running in a container

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests \
	registry/grafonnet-extras /examples/1-simple-dash.jsonnet

## Version numbering

The grafonnet-extras distributions are labeled with a number that hints at the 
currently supported release of the official grafonnet library.

The dist version is in the form:

	major.minor

The major number hints at compatibility with a grafonnet major release.
The minor number in for internal tracking not associated with grafonnet releases.

## Compiling dashboards

Assuming that the current directory contains your grafonnet-extras scripts

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests
	grafonnet-extras /examples/1-simple-dash.jsonnet

## grafonnet-extras unit testing

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests
	grafonnet-extras /tests/dash-test.jsonnet

## More code and documentation

- [Sample code](examples/README.md).
- [Jsonnet documentation](docs/README.md).
- [Features history](HISTORY.md).

