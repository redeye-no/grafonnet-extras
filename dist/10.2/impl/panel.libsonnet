/*

*/

local grafonnet = import "github.com/grafana/grafonnet/gen/grafonnet-v10.2.0/main.libsonnet";

{
	new(
		title = "",
		type = "stat"
	) ::
	grafonnet.panel[type].new(title)
	+ grafonnet.panel[type].panelOptions.withType()
	,
	
	/** ################################################################
	 * @name Dashboard panel row
	 *
	 * @param title Row title.
	 *
	 */
	build(
		title = "",
		type = "stat",
		plot = {},
		configs = null,
		geometry = {},
		index = 0
	) :: (
		grafonnet.panel[type].queryOptions.withTargetsMixin(plot)
		+ (import "panel/options.libsonnet").build(type = type, plot = plot, configs = configs)
		+ (import "panel/overrides.libsonnet").build(type = type, plot = plot, configs = configs, index = index)
		+ (import "panel/thresholds.libsonnet").build(type = type, plot = plot, configs = configs, index = index)
		# + (import "panel/mappings.libsonnet").build(type = type, plot = plot, configs = configs, index = index)
		# + (import "panel/alerts.libsonnet").build(type = type, plot = plot, configs = configs, index = index)
		+ (import "panel/geometry.libsonnet").build(type = type, geometry = geometry)
	)
	,	
}
