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

# Import plot defs and dashboard inputs
local plots = import "./plots.libsonnet";
local nputs = import "./inputs.libsonnet";

local inputs = [ nputs.environment(), nputs.component() ];

# Create panels that will render the plots in a dashboard
local panels = [
		extras.panels.new(
			title = "Up/down", 
			type = "stat",
			plots = [ plots.upDownPlot() ]
		),
		extras.panels.new(
			title = "Used Memory", 
			type = "timeSeries",
			plots = [ plots.usedMemoryPlot(), plots.committedMemoryPlot() ],
			configs = extras.configs
		),
		extras.panels.new(
			title = "Used Memory", 
			type = "gauge",
			plots = [ plots.usedMemoryPlot(), plots.committedMemoryPlot() ],
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
	inputs = inputs,
	grid = grid
)
	
