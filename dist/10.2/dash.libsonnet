/**
 * @param refresh Auto-refresh interval, e.g. `'30s'`
 * @param uid Dashboard identifier (string 8-40).
 * @param schemaVersion Version of the Grafana JSON schema.
 * @param timezone (default: `'browser'`) Timezone of the dashboard, `'utc'` or `'browser'`
 *
 */
local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v10.2.0/main.libsonnet";
local ec = import "github.com/redeye-no/grafonnet-extras/dist/10.2/configs.libsonnet";
local dashboard = grafonnet.dashboard;

{	
	new(
		title = "Unnamed Extras Dashboard",
		description = "",
		uid = "",
		editable = "false",
		timezone = "utc",
		schemaVersion = "38",
		configs = ec,
		grid = null,
		panels = [],
		inputs = [],
		links = [],
	) ::
		dashboard.new("")
		+ dashboard.withUid(uid)
		+ dashboard.withTitle(title)
		+ dashboard.withDescription(description)
		+ dashboard.withEditable(editable)
		+ dashboard.withRefresh(configs.intervals.refreshDash)
		+ dashboard.withTimezone(timezone)
		+ dashboard.withLinks(links)
		+ dashboard.withSchemaVersion(schemaVersion)
		+ dashboard.withVariables(inputs)
		+ dashboard.time.withFrom(configs.intervals.searchTime + "-" + configs.intervals.searchWindow)
		+ dashboard.time.withTo(configs.intervals.searchTime)
		
		+ (
			if "array" == std.type(grid) then 
				dashboard.withPanels(grid)
			else 
				dashboard.withPanels(panels)
		)
}

