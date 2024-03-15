# grafonnet-extras

I can build a simple Grafana dashboard in less than 10 lines of code!

grafonnet-extras brings an OO-friendly programming interface to Grafana dashboards.

This completely removes the nede to know and write Grafonnet, or the underlying JSON.

## Requirements

grafonnet-extras requires Jsonnet to run.

## Getting started

grafonnet-extras works by processing input files written in Jsonnet form. The output is a JSON file that describes a Grafana dashboard.
The output files can then be uploaded into a Grafana instance, or deployed as provisioned dashboards.

### Installation

If Jsonnet is already installed, add grafonnet-extras with

	jb install github.com/redeye-no/grafonnet-extras/dist/10.2/@main

For container-savvy users, a grafonnet-extras image can be built using

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

## Code example

Import the extras library

	local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";

First, we create a plot (a query with hints on how to display the results)

	local usedMemoryPlot = 
		extras.sources.plot(
			ref = "mem_used",
			legend = "used", 
			query = "base_memory_usedHeap_bytes", 
			datasource = extras.configs.uids.prometheus
	);

Now create panels that will render the plots in a dashboard

	local panels = [
		extras.panels.new(
			title = "Heap memory", 
			type = "timeSeries",
			queries = [ usedMemoryPlot ]
		) 
	];

Add the panels to a dashboard

	extras.dashboard.new(
		title = "First extras",
		uid = "52182d76-54c7-4b2f-b88c-4b41cf520e1d",
		panels = panels)

Tada! We have a dashboard,... in less than 10 lines!

See more examples in the examples folder in this repo.

## Compiling dashboards

Assuming that the current directory contains your grafonnet-extras scripts

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests
	grafonnet-extras /examples/1-simple-dash.jsonnet

## grafan-extras unit testing

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests
	grafonnet-extras /tests/dash-test.jsonnet


