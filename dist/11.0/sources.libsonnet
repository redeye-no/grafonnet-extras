/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
	local timeSeries = grafonnet.panel.timeSeries,
	local fieldOverride = grafonnet.panel.timeSeries.fieldOverride,
	local custom = timeSeries.fieldConfig.defaults.custom,
	local options = timeSeries.options,
    
	/**
	 * A plot is a construct that defines the presentation of data.
	 * In addition to the dataset (query and datasource), a plot also
	 * includes rendering hints such as placement, colours and legends.
	 *
	 * @name plot
	 *
	 * @param ref Reference identifier for the query result.
	 * @param query Query for graph data.
	 * @param datasource Target datasource.
	 * @param legend Legend text.
	 * @param legendMode table.
	 * @param legendPlacement auto, left, right.
	 * @param yAxisPlacement Placement of the Y-axis (left or right).
	 * @param yAxisLogScale If provided, the Y-axis will be logarithmic and the 
	 * 	numeric value of this param will be the log base.
	 *
	 */
    "#plot":: d.func.new(
        |||
            A plot is an object that defines a datasource, and provides visualisation constraints/configurations.
            The configuration parameters include legends and axis settings.
        |||,
        args=[
            d.arg("ref", d.T.array, []),
            d.arg("legend", d.T.string, []),
            d.arg("description", d.T.array, []),
            d.arg("query", d.T.object, []),
            d.arg("unit", d.T.array, []),
            d.arg("datasource", d.T.object, []),
            d.arg("legendMode", d.T.string, "list, table, hidden"),
            d.arg("legendPlacement", d.T.string, "bottom, right"),
            d.arg("yAxisPlacement", d.T.string, "auto, left, right"),
            d.arg("yAxisLogScale", d.T.number, "0, 2, 10")
        ],
    ),
	plot(
		ref = null,
		legend = "",
		description = "", 
		query = null,
		unit = null, 
		datasource = null,
		legendMode = "list",
		legendPlacement = "bottom",
		yAxisPlacement = "auto",
		yAxisLogScale = 0,
	) :: { 
		ref: ref,
		refId: ref,
		expr: query, 
		datasource: { type: "datasource", uid: datasource },
		legend: legend, 
		legendMode: legendMode,
		legendPlacement: legendPlacement,
		yAxisPlacement: yAxisPlacement,
		yAxisLogScale: yAxisLogScale,
		unit: unit
	},
						
	/**
	 * Test data
	 *
	 * @format Test data type, enums: ['random_walk', 'slow_query', 'random_walk_with_error',
	 *  'random_walk_table', 'exponential_heatmap_bucket_data', 'linear_heatmap_bucket_data',
	 *  'no_data_points', 'datapoints_outside_range', 'csv_metric_values', 'predictable_pulse',
	 *  'predictable_csv_wave', 'streaming_client', 'simulation', 'usa', 'live', 'grafana_api',
	 *  'arrow', 'annotations', 'table_static', 'server_error_500', 'logs', 'node_graph',
	 *  'flame_graph', 'raw_frame', 'csv_file', 'csv_content', 'trace', 'manual_entry',
	 *  'variables-query'], name: 'value', type: 'string' }]
	 */
    "#testing":: d.func.new(
        |||
            A prometheus query definition.
        |||,
        args=[
            d.arg("format", d.T.string, "random_walk"),
            d.arg("legend", d.T.string, ""),
            d.arg("datasource", d.T.object, { type: "datasource", uid: "grafana" })
        ],
    ),
	testing(
		format = "random_walk",
		legend = "",
		datasource = { type: "datasource", uid: "grafana" },
		
		# the following fields are just to silence the manifestor,
		# so devs can easily switch between $.plot and $.testing.
		ref = null,
		description = "", 
		query = null,
		unit = "", 
		colors = {},
		yAxisPlacement = "auto",
		yAxisLogScale = 0,		
	) :: 
	grafonnet.query.testData.withDatasource(datasource)
	+ grafonnet.query.testData.withScenarioId(format)
	
}
