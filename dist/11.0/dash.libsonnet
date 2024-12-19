/**
 * @param refresh Auto-refresh interval, e.g. `'30s'`
 * @param uid Dashboard identifier (string 8-40).
 * @param schemaVersion Version of the Grafana JSON schema.
 * @param timezone (default: `'browser'`) Timezone of the dashboard, `'utc'` or `'browser'`
 *
 */
local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.2.0/main.libsonnet";
local ec = import "github.com/redeye-no/grafonnet-extras/dist/11.0/configs.libsonnet";
local dashboard = grafonnet.dashboard;
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
    "#new":: d.func.new(
        |||
            Create and configures a new dashboard
        |||,
        args=[
            d.arg("title", d.T.string, "Unnamed Extras Dashboard"),
            d.arg("description", d.T.string, ""),
            d.arg("uid", d.T.string, ""),
            d.arg("editable", d.T.string, "false, true"),
            d.arg("timezone", d.T.string, "utc, 'IANA TZDB zone ID', browser"),
            d.arg("schemaVersion", d.T.number, 39),
            d.arg("configs", d.T.object, "extras.config"),
            d.arg("grid", d.T.object, null),
            d.arg("panels", d.T.array, []),
            d.arg("inputs", d.T.array, []),
            d.arg("links", d.T.array, [])
        ],
    ),
	new(
		title = "Unnamed Extras Dashboard",
		description = "",
		uid = "",
		editable = "false",
		timezone = "utc",
		schemaVersion = "39",
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

