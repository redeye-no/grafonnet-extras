/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.2.0/main.libsonnet";
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

	/*
	alertList
    annotationsList
    barChart
    barGauge
    candlestick
    canvas
    dashboardList
    datagrid
    debug
    gauge
    geomap
    heatmap
    histogram
    logs
    news
    nodeGraph
    pieChart
    row
    stat
    stateTimeline
    statusHistory
    table
    text
    timeSeries
    trend
    xyChart
	*/
	def() ::: ({}),
	
}

