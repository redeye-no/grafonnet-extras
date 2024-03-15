/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v10.2.0/main.libsonnet";

{

	/** ################################################################
	 * @name Dashboard panel row
	 *
	 * @param title Row title.
	 *
	 */
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
	 * @param type The panel type (e.g. stat, timeSeries, heatMap, etc.).
	 * @param plots Data plots.
	 * @param configs (default `{}) custom configurations.
	 *
	 */
	new(
		title = "",
		type = "stat",
		plots = [],
		configs = null,
		geometry = {}
	) :: 		
	(import "impl/panel.libsonnet").new(title = title, type = type)

	+ (
		local options = [(import "impl/panel.libsonnet").build(type = type, plot = plots[i], configs = configs, index = i),
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

