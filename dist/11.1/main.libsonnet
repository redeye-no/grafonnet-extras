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

local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
    "#": d.pkg(
        name= "grafonnet-extras",
        url= "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet",
        help= |||
            OO-friendly templating interface to Grafana dashboards.

            This library contains the following packages:

            `local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";`
            `extras.dashboard` - create dashboards
            `extras.panels` - create and configure panels (plots)
            `extras.inputs` - inputs/variables
            `extras.sources` - visualisation sources
            `extras.configs` - visualisation configs

            ## Usage
                local extras = import "github.com/redeye-no/grafonnet-extras/dist/11.1/main.libsonnet";
                extras.dashboard.new(
                    title = "Extras: Simple Dash",
                    uid = "02042265-58c5-478f-980e-420d8519961f",
                    panels = panels)
        |||
    ),
	dashboard: import "dash.libsonnet",
	panels: import "panels.libsonnet",
	inputs: import "inputs.libsonnet",
	sources: import "sources.libsonnet",
	configs: import "configs.libsonnet",
	utils: import "utils.libsonnet",
}


