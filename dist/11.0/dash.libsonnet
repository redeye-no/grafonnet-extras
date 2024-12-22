/**
 * @param refresh Auto-refresh interval, e.g. `'30s'`
 * @param uid Dashboard identifier (string 8-40).
 * @param schemaVersion Version of the Grafana JSON schema.
 * @param timezone (default: `'browser'`) Timezone of the dashboard, `'utc'` or `'browser'`
 *
 */
local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";
local ec = import "github.com/redeye-no/grafonnet-extras/dist/11.0/configs.libsonnet";
local dashboard = grafonnet.dashboard;
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
    "#new":: d.func.new(
        |||
            Create and configures a new dashboard.

            ## Usage
            The most basic dashboard can be created by providing a title, unique identifier, and a panel.

                local extras = import "github.com/redeye-no/grafonnet-extras/dist/10.2/main.libsonnet";
                extras.dashboard.new(
                    title = "Extras: Simple Dash",
                    uid = "02042265-58c5-478f-980e-420d8519961f",
                    panels = panels)

            The panels attribute takes an array of panels that will be laid out in the dashboard.
            Dash attributes:

            |Attribute|Description|
            |----|----|
            |`title` | Dashboard title. |
            |`uid` | Unique identifier. |
            |`editable` | Enable dashboard editting (default = false). |
            |`timezone` | Timezone ID (default = utc). |
            |`configs` | |
            |`panels` | Array of panels. Layout is determined at runtime by Grafana. |
            |`grid` | Using `grid` in place of `panels` allows for more control over how panels are sized and laid out. |
            |`inputs` | Dashboard variablesavailable to the dashboard. |
            |`links` | |
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

