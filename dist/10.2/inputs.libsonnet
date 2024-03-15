/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v10.2.0/main.libsonnet";
local configs = import "github.com/redeye-no/grafonnet-extras/dist/10.2/configs.libsonnet";
local dash = import "github.com/redeye-no/grafonnet-extras/dist/10.2/dash.libsonnet";
local panel = import "github.com/redeye-no/grafonnet-extras/dist/10.2/panel.libsonnet";

local dashboard = grafonnet.dashboard;
local variable = grafonnet.dashboard.variable;

{

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

	/** ################################################################
	 * Query input variable constructor
	 *
	 * @name queryInputVariable
	 *
	 * @param title Reference identifier for the query result.
	 * @param isDropDown Query for graph data.
	 * @param type Target datasource.
	 * @param tags Legend text.
	 * @param tooltip Placemet of the Y-axis (left or right).
	 * 
	 */
	query(
		name = "",
		label = "",
		description = "",
		query = "",
		datasource = "",
		uid = "",
	) ::
		variable.query.new(
			name = name,
			query = query,
		)
		.withDatasource(datasource, uid)
			
	,

	/** ################################################################
	 * Query input variable constructor
	 *
	 * @name constantInputVariable
	 *
	 * @param title Reference identifier for the query result.
	 * @param isDropDown Query for graph data.
	 * @param type Target datasource.
	 * @param tags Legend text.
	 * @param tooltip Placemet of the Y-axis (left or right).
	 * 
	 */
	constant(
		name = "",
		value = "",
	) ::
		variable.constant.new(
			name = name,
			value = value,
		)
	
	,

	/** ################################################################
	 * Textbox input variable constructor
	 *
	 * @name textInputVariable
	 *
	 * @param title Reference identifier for the query result.
	 * @param isDropDown Query for graph data.
	 * @param type Target datasource.
	 * @param tags Legend text.
	 * @param tooltip Placemet of the Y-axis (left or right).
	 * 
	 */
	text(
		name = "",
		label = "",
		description = "",
		value = "",
	) :: 
		variable.textbox.new(
			name = name,
			default = value,
		)
		+ variable.textbox.generalOptions.withDescription(description)
			
	,

	/** ################################################################
	 * Base input variable constructor
	 *
	 * @name customVariable
	 *
	 * @param title Reference identifier for the query result.
	 * @param isDropDown Query for graph data.
	 * @param type Target datasource.
	 * @param tags Legend text.
	 * @param tooltip Placemet of the Y-axis (left or right).
	 * 
	 */
	custom(
		name = "",
		label = "",
		description = "",
		hide = 0,
		options = [],
		type = "custom",
	) :: 
		variable.custom.new(
			name = name,
			values = options,
		)
		+ variable.custom.generalOptions.withDescription(description)
	
}

