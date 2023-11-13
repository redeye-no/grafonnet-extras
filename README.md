# grafonnet-extras

A thin jsonnet library on top of grafonnet that introduces an OO-friendly
syntax to building Grafana dashboards.

grafonnet-extras allows traditional developers to work with grafonnet
like a typical programming language.

## Requirements

grafonnet-extras requires Grafonnet and Jsonnet to run.

For container-savvy users, an imagefile for building container images in included.

## Installation

If Jsonnet is already installed, add grafonnet-extras with

	jb install github.com/redeye-no/grafonnet-extras/dist/10.0/@main

For container-savvy users, an image build file is included for running in a container.

	cd grafonnet-extras
	nerdctl build -t grafonet-extras:latest -f grafonnet-extras.imagefile .
	nerdctl tag grafonet-extras:latest registry/grafonnet-extras:latest
	nerdctl push registry/grafonnet-extras:latest

Note: replace registry with your actual registry

## Version numbering

The grafonnet-extras distributions are labeled with a number that hints at the 
currently supported release of the official grafonnet library.

The dist version is in the form:

	major.minor

The major number hints at compatibility with a grafonnet major release.
The minor number in for internal tracking not associated with grafonnet releases.

## Code example

Import the extras library

	local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.0/main.libsonnet";

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

See more examples in the examples folder in this repo.

## Compiling dashboards

Assuming that the current directory contains your grafonnet-extras scripts

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests
	-it registry/grafonnet-extras \
	-J /jsonnet-libs \
	/examples/1-simples-dash.jsonnet

## grafan-extras unit testing

	nerdctl run --rm \
	-v $(pwd)/examples:/examples \
	-v $(pwd)/test:/tests
	-it registry/grafonnet-extras \
	-J /jsonnet-libs \
	/tests/dash-test.jsonnet

Note: replace registry with your actual registry




