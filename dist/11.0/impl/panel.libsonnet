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
		settings = { type: "stat" },
		plot = {},
		configs = null,
		geometry = {},
		index = 0
	) :: (
		grafonnet.panel[settings.type].queryOptions.withTargetsMixin(plot)
		+ (import "panel/configs.libsonnet").build(settings = settings, plot = plot)
		+ (import "panel/options.libsonnet").build(settings = settings, plot = plot, configs = configs)
		+ (import "panel/overrides.libsonnet").build(settings = settings, plot = plot, configs = configs, index = index)
		+ (import "panel/thresholds.libsonnet").build(settings = settings, plot = plot, index = index)
		+ (import "panel/mappings.libsonnet").build(settings = settings, plot = plot, index = index)
		# + (import "panel/alerts.libsonnet").build(settings = settings, plot = plot, configs = configs, index = index)
		+ (import "panel/geometry.libsonnet").build(settings = settings, geometry = geometry)
	)
	,	
}
