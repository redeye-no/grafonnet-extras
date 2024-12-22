/*
What this does
- introduces multiple panels in a dashboard
- render panels in a grid layout

Things to note
- with a grid, panels get laid out one row at a time (each row is 24 units wide)
- each panel in this example is set to 8 units wide
- a plot can be visualised in different panels

What next
- plots can be defined in separate files so they can be reused in various dashboards
- duplicate the "Used Memory" timeSeries and change the type of the copy to "gauge" (now it's easy to compare usability)
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
			plots = [ plots.usedMemoryPlot() ],
		)
	];

# Add the panel into a row...
local rows = [
		extras.panels.row(title = "My First Row", panels = panels)
	];

# then pack the row into a grid
local grid = extras.panels.grid(rows = rows, panelWidth = 8);

# Now render grid in a dashboard
extras.dashboard.new(
	title = "Extras: 2. Grid Dash",
	uid = "d24ee9aa-76a3-405b-b6c8-100ce990b7b9",
	inputs = inputs,
	grid = grid)
