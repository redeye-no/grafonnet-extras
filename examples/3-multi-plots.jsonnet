/*
What this does
- introduces plot configuration
- render panels in a grid layout

Things to note
- with a grid, panels get laid out one row at a time (each row is 24 units wide)
- each panel in this example is set to 8 units wide
- a plot can be visualised in different panels

What next
- plots can be defined in separate files so they can be reused in various dashboards
- duplicate the "Used Memory" panel in line 56, and change the type to "gauge" (now it's easy to compare usability)
- panels can be sized and positioned independently using geometry hints
*/

# Import the extras libraries

local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";

# Create a plot for each metric we'd like to visualise

local usedMemoryPlot = 
	extras.sources.plot(
		ref = "mem_used",
		legend = "used", 
		query = "base_memory_usedHeap_bytes", 
		datasource = extras.configs.uids.prometheus
	);

local committedMemoryPlot = 
	extras.sources.plot(
		ref = "mem_committed",
		legend = "committed", 
		legendPlacement = "right",
		query = "base_memory_committedHeap_bytes", 
		datasource = extras.configs.uids.prometheus
	);

local upDownPlot = 
	extras.sources.plot(
		ref = "up_down",
		legend = "state", 
		query = "up",
		datasource = extras.configs.uids.prometheus
	);


# Add the plots to a panel
local panels = [
		extras.panels.new(
			title = "Up/down", 
			type = "stat",
			plots = [ upDownPlot ]
		),
		extras.panels.new(
			title = "Used Memory", 
			type = "timeSeries",
			plots = [ usedMemoryPlot, committedMemoryPlot ],
			configs = extras.configs
		),
		extras.panels.new(
			title = "Used Memory", 
			type = "gauge",
			plots = [ usedMemoryPlot, committedMemoryPlot ],
		)
	];
	

# Add the panel into a row...
local rows = [
		extras.panels.row(title = "My Other Row", panels = panels)
	];

# then pack the row into a grid
local grid = extras.panels.grid(rows = rows, panelWidth = 8);

# Now render grid in a dashboard
extras.dashboard.new(
	title = "Extras: 3. Multiplot Dash",
	uid = "5403f355-5e45-4f7e-bb66-0bda19ff98ac",
	grid = grid
)
	
