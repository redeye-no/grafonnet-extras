/*
What this does
- render panels with multiple plots
- Configure plots with settings

Things to note
- a plot can be visualised in different panels
- a palette is provided to display plots in different colours

What next
- thresholds, overrides, mappings and transformations
*/

# Import the extras libraries
local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";

# Import plot defs and dashboard inputs
local plots = import "./plots.libsonnet";
local nputs = import "./inputs.libsonnet";
local configs = import "./configs.libsonnet";

local inputs = [ nputs.environment(), nputs.component() ];

# Create panels that will render the plots in a dashboard
local panels = [
		extras.panels.new(
			title = "Up/down", 
			settings= { type: "stat", thresholdAbsolute: configs.upDownThresholds },
			plots = [ plots.upDownPlot ]
		),
		extras.panels.new(
			title = "Used Memory", 
			settings= { type: "timeSeries", palette: configs.palette },
			plots = [ plots.usedMemoryPlot, plots.committedMemoryPlot ],
			configs = extras.configs
		),
		extras.panels.new(
			title = "Used Memory", 
			settings= { type: "gauge" },
			plots = [ plots.usedMemoryPlot, plots.committedMemoryPlot ],
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
	
