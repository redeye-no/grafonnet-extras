/*
What this does
- introduces a grafonnet-extras plot that defines a query
- introduces a panel that a plot can be added to
- render a dashboard with a timeSeries panel

Things to note
- the query in the plot is your normal grafana query
- the plot specifies a datasource that will process the query
- a panel can have more than 1 plot attached to it 

What next
- plots can be defined in separate files so they can be reused in various dashboards
- try changing the type attribute in the panel, say, from timeSeries to stat, or heatmap
- panels can be sized and positioned independently using geometry hints
*/

# Import the extras libraries

local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";

# First, we create a plot (a query with hints on how to display the results)

local usedMemoryPlot = 
	extras.sources.plot(
		ref = "mem_used",
		legend = "used", 
		unit = "cm",
		query = "base_memory_usedHeap_bytes", 
		datasource = extras.configs.uids.prometheus
	);

# Now create panels that will render the plots in a dashboard

local panels = [
		extras.panels.new(
			title = "Used Memory", 
			type = "timeSeries",
			plots = [ usedMemoryPlot ],
			geometry = { x:1, y:1, w: 8, h:8 }
		) 
	];

# Add the panels to a dashboard

extras.dashboard.new(
	title = "Extras: 1. Simple Dash",
	uid = "02042265-58c5-478f-980e-420d8519961f",
	panels = panels)

