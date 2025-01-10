/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	new(
		title = "",
		settings = { type: "stat" },
		geometry = {}
	) ::
	grafonnet.panel[settings.type].new(title)
	+ grafonnet.panel[settings.type].panelOptions.withType()
    + (
        if std.objectHas(geometry, "x")  then
            grafonnet.panel[settings.type].gridPos.withX(geometry.x)
        else {}
    )
    +(
        if std.objectHas(geometry, "y")  then
            grafonnet.panel[settings.type].gridPos.withY(geometry.y)
        else {}
    )
    + (
        if std.objectHas(geometry, "w")  then
            grafonnet.panel[settings.type].gridPos.withW(geometry.w)
        else {}
    )
    +(
        if std.objectHas(geometry, "h")  then
            grafonnet.panel[settings.type].gridPos.withH(geometry.h)
        else {}
    )
	,
	
	/** ################################################################
	 * @name Dashboard panel row
	 *
	 * @param title Row title.
	 *
	 */
	build(
		title = "",
		plot = {},
		settings = { type: "stat" },
		configs = null,
		geometry = {},
		index = 0
	) :: (
		grafonnet.panel[settings.type].queryOptions.withTargetsMixin(plot)
		+ (import "panel/configs.libsonnet").build(plot = plot, settings = settings)
		+ (import "panel/options.libsonnet").build(plot = plot, settings = settings, configs = configs)
		+ (import "panel/overrides.libsonnet").build(plot = plot, settings = settings, configs = configs, index = index)
		+ (import "panel/thresholds.libsonnet").build(plot = plot, settings = settings, index = index)
		+ (import "panel/mappings.libsonnet").build(plot = plot, settings = settings, index = index)
		+ (import "plot/transformations.libsonnet").build(plot = plot, settings = plot.settings, index = index)
		# + (import "plot/alerts.libsonnet").build(plot = plot, settings = plot.settings, configs = configs, index = index)
		# + (import "panel/geometry.libsonnet").build(settings = settings, geometry = geometry)
	)
	,	
}
