/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
	/** ################################################################
	 * @name Dashboard panel row
	 *
	 * @param title Row title.
	 *
	 */
    "#grid":: d.func.new(
        |||
            Create a new grid consisting of the row of panels provided as input.
            The panelWidth argument specifies the default size of each panel in the grid (max value is 24).
        |||,
        args=[
            d.arg("rows", d.T.array, []),
            d.arg("panelWidth", d.T.number, 1)
        ],
    ),
	grid(
		rows = [],
		panelWidth = 1,
	) :: grafonnet.util.grid.makeGrid(rows, panelWidth)
	,

	/** ################################################################
	 * @name Dashboard panel row
	 *
	 * @param title Row title.
	 *
	 */
    "#row":: d.func.new(
        "Create a new row",
        args=[
            d.arg("title", d.T.string, ""),
            d.arg("panels", d.T.array, []),
            d.arg("configs", d.T.object, null),
            d.arg("collapses", d.T.bool, false)
        ],
    ),
	row(
		title = "",
		panels = [],
		collapses = false,
	) :: grafonnet.panel.row.new(title)
	+ grafonnet.panel.row.withCollapsed(collapses)
	+ grafonnet.panel.row.withPanels(panels)
	,
	
	/** ################################################################
	 * Create an extras panel
	 *
	 * @name extras panel
	 *
	 * @param title The title of the panel.
	 * @param def Panel definitions
	 *   type - The panel type (e.g. stat, barGauge, timeSeries, heatMap, etc.).
	 *   displayMode - "basic", "lcd", "gradient"
	 *   orientation - "auto", "vertical", "horizontal"
	 * @param plots Data plots.
	 * @param configs (default `{}) custom configurations.
	 *
	 */
    "#new":: d.func.new(
        |||
            Create a new panel that can be displayed in a dashboard.
            Each visualisation is defined by one or more plots.
            A plot defines the data is to be presented/rendered in a panel.

            ## Usage
            First, create a plot (a query with hints on how to display the results)

                local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";
                local memoryUsedHeapPlot =
                    extras.sources.plot(
                        ref = "mem_used",
                        legend = "used",
                        unit = "decabyte",
                        query = "base_memory_usedHeap_bytes",
                        datasource = extras.configs.uids.prometheus
                    );

            Then create panels that will visualise the plots. A panel specifies how plots are rendered (time series, gauge, heatmap, etc.) in a dashboard.
            A single panel can harbour multiple plots.

                local panels = [
                        extras.panels.new(
                            title = "Used Memory",
                            def = { type: "timeSeries" },
                            plots = [ memoryUsedHeapPlot, memoryCommittedHeapPlot ]
                        )
                    ];

            All plots added to a panel will be rendered in a similar manner. For example, multiple plots added to a panel of type 'gauge' will
            all be drawn as gauges.
            Now the panels can be added to the dashboard for display.

                extras.dashboard.new(
                    title = "Extras: Simple Dash",
                    uid = "02042265-58c5-478f-980e-420d8519961f",
                    panels = panels)

            ## Panel configuration

            |Attribute|Description|Examples|
            |----|----|----|
            |`title` | Panel title. | Default "" |
            |`def` | Visual definition. | `{ type: "stat" }}` |
            |`plots` | Array of plots that provide the visualisation data. | `[]` |
            |`configs` | Common configuration parameters. |  |
            |`geometry` | Panel geometry in Grafana units | `{ x:1, y:1, w: 8, h:8 }` |

            ## Panel definition
            Panel definitions are controlled by the `def` argument object. The general syntax is as follows:

                { type: "panelType" }

            The `type` attribute assigns the panel a specific type of visualisation. Each type has a set of options that can be provided.
            `type` can be one of: alertlist, annonlist, barchart, candlestick, canvas, dashlist, datagrid, debug, geomap, heatmap, histogram, logs, news, nodeGraph, piechart, row, state-timeline, status-history, table, text, timeseries, trend, xychart.

            |Attribute|Description|Value, enum, examples|
            |----|----|----|
            |`decimals` | Number of decimals to display for values | - |
            |`displayMode` |  | basic, lcd, gradient |
            |`*displayMode` |  | 'auto', 'color-text', 'color-background', 'color-background-solid', 'gradient-gauge', 'lcd-gauge', 'json-view', 'basic', 'image', 'gauge', 'sparkline', 'data-links', 'custom'. |
            |`*displayMode` |  | 'list', 'table', 'hidden' |
            |`fillOpacity` |  | barchart, gauge, histogram, status-history, state-timeline, table, timeSeries, trend |
            |`gradientMode` |  | barchart, gauge, histogram, status-history, state-timeline, table, timeSeries, trend |
            |`orientation` |  | auto, vertical, horizontal. |
            |`lineWidth` |  | Unique identifier. |
            |`mappingValue` | Value mappings | `mappingValue: [ { value: "110", text: "one ten", color: "red" } ]` |
            |`mappingRange` | Value mappings by range | `mappingRange: [ { from: 0, to: 10, text: "ones", color:"green" } ]` |
            |`mappingRegex` | Value mappings using regex | `mappingRegex: [ { pattern: "[0-9]", text: "reggy", color: "#f0f0f0" } ]` |
            |`mappingSpecial` | Special value mappings | `mappingSpecial: [ { match: "nan-null", text: "special", color: "blue" } ]` |
            |`thresholdAbsolute` | Absolute threshold values | `thresholdAbsolute: [ { "color": "red", "value": 0 }, { "color": "green", "value": 1 }]` |
            |`thresholdPercent` | Percentage threshold values | `thresholdPercent: [ { "color": "red", "value": 0 }, { "color": "yellow", "value": 25 }, { "color": "green", "value": 50 }]` |
            |`thresholdStyle` | Percentage threshold values | line+area |


        |||,
        args=[
            d.arg("title", d.T.string, ""),
            d.arg("def", d.T.object, { type: "stat" }),
            d.arg("plots", d.T.object, null),
            d.arg("configs", d.T.object, null),
            d.arg("geometry", d.T.object, {})
        ],
    ),
	new(
		title = "",
		def = { type: "stat" },
		plots = [],
		configs = null,
		geometry = {}
	) :: 		
	(import "impl/panel.libsonnet").new(title = title, def = def)

	+ (
		local options = [(import "impl/panel.libsonnet").build(def = def, plot = plots[i], configs = configs, index = i),
		for i in std.range(0, std.length(plots) - 1)];
		
		/*
			Someone needs to come up with a better way to accomplish this.
			
			The result of the loop above returns an array of objects, 
			
			[ thing1, thing2, thing3 ]
			
			but the output of this function needs to be a list:
			
			{ thing1, thing2, thing3 }
			
		*/
		(
			if std.length(options) > 0 then 
				options[0]
			else {}
		)
		
		+(
			if std.length(options) > 1 then 
				options[1]
			else {}
		)
		
		+(
			if std.length(options) > 2 then 
				options[2]
			else {}
		)
		
		+(
			if std.length(options) > 3 then 
				options[3]
			else {}
		)
		
		+(
			if std.length(options) > 4 then 
				options[4]
			else {}
		)
		
		+(
			if std.length(options) > 5 then 
				options[5]
			else {}
		)
		
		+(
			if std.length(options) > 6 then 
				options[6]
			else {}
		)
		
		+(
			if std.length(options) > 7 then 
				options[7]
			else {}
		)		
	)
	,
	
	
	/** ################################################################
	 * Dashboard links constructor
	 *
	 * @name dashLink
	 *
	 * @param ref Reference identifier for the query result.
	 * @param query Query for graph data.
	 * @param datasource Target datasource.
	 * @param legend Legend text.
	 * @param yAxisPlacement Placemet of the Y-axis (left or right).
	 * @param yAxisLogScale If provided, the Y-axis will be logarithmic and the numeric value of this param will be the log base.
	 * 
	 */
	dashLink(
		title = "",
		isDropDown = false,
		type = "dashboard",
		tags = [], 
		tooltip = "",
	) ::: $.baseLink(
		title = title,
		isDropDown = isDropDown,
		type = "dashboard", 
		tags = tags,
		tooltip = tooltip,
	)
	
	+ {}
	
	,

	/** ################################################################
	 * External links constructor
	 *
	 * @name urlLink
	 *
	 * @param ref Reference identifier for the query result.
	 * @param query Query for graph data.
	 * @param datasource Target datasource.
	 * @param legend Legend text.
	 * @param yAxisPlacement Placemet of the Y-axis (left or right).
	 * @param yAxisLogScale If provided, the Y-axis will be logarithmic and the numeric value of this param will be the log base.
	 * 
	 */
	urlLink(
		title = "",
		isDropDown = false,
		tags = [], 
		tooltip = "",
		url = "",
	) ::: $.baseLink(
		title = title,
		isDropDown = isDropDown,
		type = "link", 
		tags = tags,
		tooltip = tooltip,
	)
	
	+ { url: url }
	
	,

	/** ################################################################
	 * Base link constructor
	 *
	 * @name baseLink
	 *
	 * @param title Reference identifier for the query result.
	 * @param isDropDown Query for graph data.
	 * @param type Target datasource.
	 * @param tags Legend text.
	 * @param tooltip Placemet of the Y-axis (left or right).
	 * 
	 */
	baseLink(
		title = "",
		isDropDown = false,
		type = "dashboard",
		tags = [], 
		tooltip = "",
	) ::: ({ 
		title: title,
		asDropdown: isDropDown,
		type: type, 
		tags: tags,
		tooltip: tooltip,
	})
	
	,
	
}

