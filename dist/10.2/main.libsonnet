/*

This is the grafonnet extras entry point.

main.libsonnet - shell
 - declares all shortcuts and includes all subscripts

local extras = import "github.com/azizmwondha/grafonnet-extras/main.libsonnet";

shortcuts:
extras.dashboard() - create dashboard
	

A dashboard consists of one or more individually configured panels.

+---------+  <-- Dashboard
| A  | B  |  <-- Panels
+---------+
|.._/\   _| 
| /.. \_/.|  <-- Panel
|/   .... | 
+---------+

Sample usage:

local extras = import "/templates/extras.libsonnet";

# Create a dashboard, providing some configuration attributes
extras.dashboard(
	title = "My-app health", 
	refresh = "5s",
	theme = "light",
	inputVariables = inputVariables,
	uid = "MYAPPHEALTH",
)

*/

{
	"#": {
		filename: "main.libsonnet",
		"import": "github.com/redeye-no/grafonnet-extras/dist/10.0/main.libsonnet",
		name: "grafonnet-extras",
		url: "github.com/redeye-no/grafonnet-extras",
		version: "10.1",
	},
	dashboard: import "dash.libsonnet",
	panels: import "panels.libsonnet",
	inputs: import "inputs.libsonnet",
	sources: import "sources.libsonnet",
	configs: import "configs.libsonnet",
	utils: import "utils.libsonnet",
}


