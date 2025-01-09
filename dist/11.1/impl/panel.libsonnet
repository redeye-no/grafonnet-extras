/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet";

{
	new(
		title = "",
		settings = { type: "stat" }
	) ::
	grafonnet.panel[settings.type].new(title)
	+ grafonnet.panel[settings.type].panelOptions.withType()
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
		+ (import "panel/geometry.libsonnet").build(settings = settings, geometry = geometry)
	)
	,	
}
